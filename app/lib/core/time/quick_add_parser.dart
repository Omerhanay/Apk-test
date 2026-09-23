// Regex fragments read more clearly as concatenated raw strings than interpolated ones.
// ignore_for_file: prefer_interpolation_to_compose_strings

import 'recurrence.dart';

class QuickAddResult {
  const QuickAddResult({required this.title, this.due, this.allDay = false, this.recurrence});

  final String title;
  final DateTime? due;

  /// True when a date was given without a time.
  final bool allDay;
  final Recurrence? recurrence;

  @override
  String toString() => 'QuickAddResult($title, due: $due, allDay: $allDay, recurrence: $recurrence)';
}

/// Extracts a date, time and repetition from a short English or Turkish
/// phrase ("yarın 9'da sigortayı ara", "every monday gym", "22.10.2026 dentist").
///
/// Deterministic rules only: nothing is guessed that the text doesn't say, and
/// the result is always shown to the user for review before saving.
class QuickAddParser {
  const QuickAddParser();

  static const _suffix = r"(?:'?(?:y?a|y?e|[dt]a|[dt]e|[dt]an|[dt]en|ya kadar|ye kadar))?";

  static const _weekdaysEn = {
    'monday': 1, 'tuesday': 2, 'wednesday': 3, 'thursday': 4, 'friday': 5, 'saturday': 6, 'sunday': 7,
  };
  // Longer names first so "cumartesi" isn't read as "cuma" and "pazartesi" as "pazar".
  static const _weekdaysTr = {
    'cumartesi': 6, 'pazartesi': 1, 'carsamba': 3, 'persembe': 4, 'sali': 2, 'cuma': 5, 'pazar': 7,
  };
  static const _monthsEn = {
    'january': 1, 'february': 2, 'march': 3, 'april': 4, 'may': 5, 'june': 6, 'july': 7, 'august': 8,
    'september': 9, 'october': 10, 'november': 11, 'december': 12,
    'jan': 1, 'feb': 2, 'mar': 3, 'apr': 4, 'jun': 6, 'jul': 7, 'aug': 8, 'sep': 9, 'sept': 9, 'oct': 10,
    'nov': 11, 'dec': 12,
  };
  static const _monthsTr = {
    'ocak': 1, 'subat': 2, 'mart': 3, 'nisan': 4, 'mayis': 5, 'haziran': 6, 'temmuz': 7, 'agustos': 8,
    'eylul': 9, 'ekim': 10, 'kasim': 11, 'aralik': 12,
  };

  QuickAddResult parse(String input, DateTime now) {
    final text = input.trim();
    final f = _fold(text);
    final used = List<bool>.filled(f.length, false);
    final today = DateTime(now.year, now.month, now.day);

    DateTime? date;
    ({int h, int m})? time;
    Recurrence? recurrence;

    // Returns the first match that doesn't overlap text already used, and marks it.
    RegExpMatch? take(String pattern) {
      for (final m in RegExp(pattern).allMatches(f)) {
        if (Iterable.generate(m.end - m.start, (i) => used[m.start + i]).any((u) => u)) continue;
        for (var i = m.start; i < m.end; i++) {
          used[i] = true;
        }
        return m;
      }
      return null;
    }

    String alt(Iterable<String> words) => words.join('|');
    final weekdayAlt = alt([..._weekdaysEn.keys, ..._weekdaysTr.keys]);
    int weekdayOf(String w) => _weekdaysEn[w] ?? _weekdaysTr[w]!;

    // --- Repetition -------------------------------------------------------
    if (take(r'\b(?:every\s*day|daily|her\s+gun)\b') != null) {
      recurrence = const Recurrence(Frequency.daily);
    } else if (take(r'\b(?:every\s+week|weekly|her\s+hafta)\b') != null) {
      recurrence = const Recurrence(Frequency.weekly);
    } else if (take(r'\b(?:every\s+month|monthly|her\s+ay)\b') != null) {
      recurrence = const Recurrence(Frequency.monthly);
    } else if (take(r'\b(?:every\s+year|yearly|annually|her\s+(?:yil|sene))\b') != null) {
      recurrence = const Recurrence(Frequency.yearly);
    } else if (take(r'\b(?:every|her)\s+(' + weekdayAlt + ')' + _suffix + r'\b') case final m?) {
      recurrence = const Recurrence(Frequency.weekly);
      date = _nextWeekday(today, weekdayOf(m.group(1)!), includeToday: true);
    } else if (take(r'\bevery\s+(\d{1,3})\s+days?\b') case final m?) {
      recurrence = Recurrence(Frequency.daily, interval: int.parse(m.group(1)!));
    } else if (take(r'\bher\s+(\d{1,3})\s+gunde\s+bir\b') case final m?) {
      recurrence = Recurrence(Frequency.daily, interval: int.parse(m.group(1)!));
    }

    // --- Explicit dates ---------------------------------------------------
    if (date == null) {
      if (take(r'\b(\d{4})-(\d{2})-(\d{2})\b') case final m?) {
        date = _valid(int.parse(m.group(1)!), int.parse(m.group(2)!), int.parse(m.group(3)!));
      } else if (take(r'\b(\d{1,2})[./](\d{1,2})[./](\d{4}|\d{2})\b') case final m?) {
        final y = int.parse(m.group(3)!);
        date = _valid(y < 100 ? 2000 + y : y, int.parse(m.group(2)!), int.parse(m.group(1)!));
      } else if (take(r'\b(\d{1,2})\s+(' + alt([..._monthsTr.keys, ..._monthsEn.keys]) + r')\w*(?:\s+(\d{4}))?\b')
          case final m?) {
        final month = _monthsTr[m.group(2)] ?? _monthsEn[m.group(2)]!;
        date = _dayMonth(today, int.parse(m.group(1)!), month, int.tryParse(m.group(3) ?? ''));
      } else if (take(r'\b(' + alt(_monthsEn.keys) + r')\w*\s+(\d{1,2})(?:st|nd|rd|th)?(?:,?\s+(\d{4}))?\b')
          case final m?) {
        date = _dayMonth(today, int.parse(m.group(2)!), _monthsEn[m.group(1)]!, int.tryParse(m.group(3) ?? ''));
      }
    }

    // --- Relative dates ---------------------------------------------------
    if (date == null) {
      if (take(r'\b(?:day\s+after\s+tomorrow|obur\s+gun|yarindan\s+sonra)\b') != null) {
        date = today.add(const Duration(days: 2));
      } else if (take(r'\b(?:tonight|bu\s+aksam)\b') != null) {
        date = today;
        time ??= (h: 20, m: 0);
      } else if (take(r'\b(?:tomorrow|yarin' + _suffix + r')\b') != null) {
        date = today.add(const Duration(days: 1));
      } else if (take(r'\b(?:today|bugun' + _suffix + r')\b') != null) {
        date = today;
      } else if (take(r'\bin\s+(\d{1,3})\s+(day|week|month)s?\b') case final m?) {
        date = _offset(today, int.parse(m.group(1)!), m.group(2)!);
      } else if (take(r'\b(\d{1,3})\s+(gun|hafta|ay)\s+sonra\b') case final m?) {
        date = _offset(today, int.parse(m.group(1)!), const {'gun': 'day', 'hafta': 'week', 'ay': 'month'}[m.group(2)]!);
      } else if (take(r'\b(?:(next|this|on|haftaya|gelecek|bu)\s+)?(' + weekdayAlt + ')' + _suffix + r'\b')
          case final m?) {
        final weekday = weekdayOf(m.group(2)!);
        date = switch (m.group(1)) {
          'next' || 'haftaya' || 'gelecek' => _weekdayNextWeek(today, weekday),
          'this' || 'bu' => _nextWeekday(today, weekday, includeToday: true),
          _ => _nextWeekday(today, weekday, includeToday: false),
        };
      }
    }

    // --- Times ------------------------------------------------------------
    if (time == null) {
      if (take(r'\b(?:at\s+)?(\d{1,2})(?::(\d{2}))?\s*(am|pm)\b') case final m?) {
        var h = int.parse(m.group(1)!) % 12;
        if (m.group(3) == 'pm') h += 12;
        time = _validTime(h, int.tryParse(m.group(2) ?? '0')!);
      } else if (take(r'\b(sabah|ogleden\s+sonra|aksam|gece)\s+(?:saat\s+)?(\d{1,2})(?:[:.](\d{2}))?' + _suffix + r'\b')
          case final m?) {
        var h = int.parse(m.group(2)!);
        if (m.group(1) != 'sabah' && h < 12) h += 12;
        time = _validTime(h == 24 ? 0 : h, int.tryParse(m.group(3) ?? '0')!);
      } else if (take(r'\b(?:at|saat)\s+(\d{1,2})(?:[:.](\d{2}))?' + _suffix + r'\b') case final m?) {
        time = _validTime(int.parse(m.group(1)!), int.tryParse(m.group(2) ?? '0')!);
      } else if (take(r"\b(\d{1,2})(?::(\d{2}))?'[dt][ae]\b") case final m?) {
        time = _validTime(int.parse(m.group(1)!), int.tryParse(m.group(2) ?? '0')!);
      } else if (take(r'\b(\d{1,2}):(\d{2})\b') case final m?) {
        time = _validTime(int.parse(m.group(1)!), int.parse(m.group(2)!));
      } else if (take(r'\b(?:noon|ogle(?:n|yin)?)\b') != null) {
        time = (h: 12, m: 0);
      }
    }

    // --- Combine ----------------------------------------------------------
    // A repetition with no start date starts today.
    if (date == null && recurrence != null) date = today;
    if (date == null && time != null) {
      final candidate = DateTime(today.year, today.month, today.day, time.h, time.m);
      date = candidate.isAfter(now) ? today : today.add(const Duration(days: 1));
    }
    if (recurrence != null && recurrence.frequency == Frequency.monthly && date != null) {
      recurrence = Recurrence(Frequency.monthly, interval: recurrence.interval, monthDay: date.day);
    }

    final due = date == null ? null : DateTime(date.year, date.month, date.day, time?.h ?? 0, time?.m ?? 0);
    return QuickAddResult(
      title: _title(text, used),
      due: due,
      allDay: due != null && time == null,
      recurrence: recurrence,
    );
  }

  /// Lowercases with Turkish-aware, length-preserving folding so match
  /// positions map back onto the original text.
  static String _fold(String s) {
    final out = StringBuffer();
    for (final unit in s.split('')) {
      final folded = switch (unit) {
        'İ' || 'I' || 'ı' => 'i',
        'Ç' || 'ç' => 'c',
        'Ğ' || 'ğ' => 'g',
        'Ö' || 'ö' => 'o',
        'Ş' || 'ş' => 's',
        'Ü' || 'ü' => 'u',
        '’' => "'",
        _ => unit.toLowerCase(),
      };
      out.write(folded.length == 1 ? folded : unit);
    }
    return out.toString();
  }

  static const _connectors = {'at', 'on', 'by', 'in', 'every', 'saat', 'her', 'de', 'da'};

  static String _title(String original, List<bool> used) {
    final kept = StringBuffer();
    for (var i = 0; i < original.length; i++) {
      kept.write(used[i] ? ' ' : original[i]);
    }
    final words = kept.toString().split(RegExp(r'\s+')).where((w) => w.isNotEmpty).toList();
    while (words.isNotEmpty && _connectors.contains(_fold(words.last).replaceAll(RegExp(r'[^\w]'), ''))) {
      words.removeLast();
    }
    while (words.isNotEmpty && _connectors.contains(_fold(words.first).replaceAll(RegExp(r'[^\w]'), ''))) {
      words.removeAt(0);
    }
    final title = words.join(' ').replaceAll(RegExp(r'^[\s,.;:-]+|[\s,.;:-]+$'), '');
    return title.isEmpty ? original : title;
  }

  static DateTime? _valid(int y, int m, int d) {
    if (m < 1 || m > 12 || d < 1) return null;
    final date = DateTime(y, m, d);
    return date.month == m && date.day == d ? date : null;
  }

  static ({int h, int m})? _validTime(int h, int m) => h >= 0 && h < 24 && m >= 0 && m < 60 ? (h: h, m: m) : null;

  /// A day and month without a year means the next time that date comes around.
  static DateTime? _dayMonth(DateTime today, int day, int month, int? year) {
    if (year != null) return _valid(year, month, day);
    final thisYear = _valid(today.year, month, day);
    if (thisYear != null && !thisYear.isBefore(today)) return thisYear;
    return _valid(today.year + 1, month, day);
  }

  static DateTime _offset(DateTime today, int n, String unit) => switch (unit) {
        'week' => DateTime(today.year, today.month, today.day + 7 * n),
        'month' => DateTime(today.year, today.month + n, today.day),
        _ => DateTime(today.year, today.month, today.day + n),
      };

  static DateTime _nextWeekday(DateTime today, int weekday, {required bool includeToday}) {
    var delta = (weekday - today.weekday) % 7;
    if (delta == 0 && !includeToday) delta = 7;
    return DateTime(today.year, today.month, today.day + delta);
  }

  /// "haftaya salı" / "next tuesday": that weekday in the following Monday-based week.
  static DateTime _weekdayNextWeek(DateTime today, int weekday) {
    final nextMonday = DateTime(today.year, today.month, today.day - (today.weekday - 1) + 7);
    return DateTime(nextMonday.year, nextMonday.month, nextMonday.day + weekday - 1);
  }
}
