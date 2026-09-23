import '../text/search_fold.dart';

/// Field keys shared with the relay's document extractor.
const dateFieldKeys = {'expires_on', 'starts_on', 'due_on', 'issued_on', 'renews_on'};
const textFieldKeys = {'policy_number', 'provider', 'vehicle_plate', 'vehicle_model', 'amount', 'reference'};

class ExtractedField {
  const ExtractedField({
    required this.key,
    required this.value,
    required this.quote,
    required this.confidence,
    this.page,
    this.origin = 'local',
  });

  final String key;

  /// ISO date (yyyy-mm-dd) for date fields, text otherwise.
  final String value;

  /// The passage of the document the value was read from, shown to the user.
  final String quote;
  final double confidence;
  final int? page;

  /// local | ai
  final String origin;

  bool get isDate => dateFieldKeys.contains(key);
}

/// Reads dates and identifiers from document text with fixed rules.
///
/// A date is only classified (e.g. as the expiry) when a known label appears
/// just before it; otherwise nothing is guessed. Works on English and Turkish.
class FieldExtractor {
  const FieldExtractor();

  static const _dateLabels = <String, List<String>>{
    'expires_on': [
      'bitis tarihi', 'bitis', 'son gecerlilik tarihi', 'son gecerlilik', 'gecerlilik tarihi', 'vade sonu',
      'police bitis', 'sona erme', 'expiry date', 'date of expiry', 'expiration date', 'expires on', 'expires',
      'valid until', 'valid thru', 'end date',
    ],
    'starts_on': ['baslangic tarihi', 'baslangic', 'yururluk tarihi', 'start date', 'effective date', 'valid from', 'coverage start'],
    'due_on': ['son odeme tarihi', 'son odeme', 'odeme tarihi', 'due date', 'payment due', 'pay by'],
    'issued_on': ['duzenleme tarihi', 'tanzim tarihi', 'verilis tarihi', 'fatura tarihi', 'date of issue', 'issue date', 'issued on', 'invoice date'],
    'renews_on': ['yenileme tarihi', 'renewal date', 'renews on', 'muayene gecerlilik', 'muayene tarihi', 'next inspection'],
  };

  static const _months = {
    'ocak': 1, 'subat': 2, 'mart': 3, 'nisan': 4, 'mayis': 5, 'haziran': 6, 'temmuz': 7, 'agustos': 8,
    'eylul': 9, 'ekim': 10, 'kasim': 11, 'aralik': 12,
    'january': 1, 'february': 2, 'march': 3, 'april': 4, 'may': 5, 'june': 6, 'july': 7, 'august': 8,
    'september': 9, 'october': 10, 'november': 11, 'december': 12,
    'jan': 1, 'feb': 2, 'mar': 3, 'apr': 4, 'jun': 6, 'jul': 7, 'aug': 8, 'sep': 9, 'oct': 10, 'nov': 11, 'dec': 12,
  };

  /// How far before a date its label may appear.
  static const _labelWindow = 40;

  List<ExtractedField> extract(List<String> pages) {
    final fields = <ExtractedField>[];
    for (var i = 0; i < pages.length; i++) {
      fields.addAll(_fromPage(pages[i], i + 1));
    }
    // One value per key: the most confident, then the earliest page.
    final best = <String, ExtractedField>{};
    for (final f in fields) {
      final current = best[f.key];
      if (current == null || f.confidence > current.confidence) best[f.key] = f;
    }
    return best.values.toList();
  }

  List<ExtractedField> _fromPage(String text, int page) {
    // Folding is length-preserving for the characters that matter here, so
    // offsets in the folded text map back onto the original for quotes.
    final folded = _fold(text);
    final out = <ExtractedField>[];

    for (final d in _dates(folded)) {
      final before = folded.substring((d.start - _labelWindow).clamp(0, folded.length), d.start);
      String? key;
      var labelAt = -1;
      for (final entry in _dateLabels.entries) {
        for (final label in entry.value) {
          final at = before.lastIndexOf(label);
          // The nearest label wins, so "Start: 1.1 End: 31.12" reads correctly.
          if (at > labelAt) {
            labelAt = at;
            key = entry.key;
          }
        }
      }
      if (key == null) continue;
      out.add(ExtractedField(key: key, value: d.iso, quote: _quote(text, d.start - before.length + labelAt, d.end), confidence: 0.8, page: page));
    }

    void labelled(String key, RegExp pattern, {double confidence = 0.75}) {
      final m = pattern.firstMatch(folded);
      if (m == null) return;
      // The value group ends every pattern, so its offset is at the match's tail.
      final groupStart = m.start + m[0]!.lastIndexOf(m[1]!);
      final value = text.substring(groupStart, groupStart + m[1]!.length).trim();
      if (value.isEmpty) return;
      out.add(ExtractedField(key: key, value: value, quote: _quote(text, m.start, m.end), confidence: confidence, page: page));
    }

    labelled('policy_number', RegExp(r'(?:police\s*(?:no|numarasi)|policy\s*(?:no|number|#))\s*[:.]?\s*([a-z0-9][a-z0-9\-/]{3,30})'));
    labelled('vehicle_plate', RegExp(r'(?:plaka|plate)\s*(?:no)?\s*[:.]?\s*(\d{2}\s?[a-z]{1,3}\s?\d{2,4})\b'));
    labelled('reference', RegExp(r'(?:fatura\s*no|invoice\s*(?:no|number)|pnr|rezervasyon\s*no|booking\s*ref(?:erence)?)\s*[:.]?\s*([a-z0-9]{5,20})\b'), confidence: 0.7);
    return out;
  }

  Iterable<({int start, int end, String iso})> _dates(String f) sync* {
    String iso(int y, int m, int d) {
      final date = DateTime(y, m, d);
      if (date.year != y || date.month != m || date.day != d) return '';
      return '${y.toString().padLeft(4, '0')}-${m.toString().padLeft(2, '0')}-${d.toString().padLeft(2, '0')}';
    }

    final patterns = <(RegExp, String Function(RegExpMatch))>[
      (RegExp(r'\b(\d{1,2})[./-](\d{1,2})[./-](\d{4})\b'), (m) => iso(int.parse(m[3]!), int.parse(m[2]!), int.parse(m[1]!))),
      (RegExp(r'\b(\d{4})-(\d{2})-(\d{2})\b'), (m) => iso(int.parse(m[1]!), int.parse(m[2]!), int.parse(m[3]!))),
      (RegExp(r'\b(\d{1,2})\s+(' + _months.keys.join('|') + r')[a-z]*\.?\s+(\d{4})\b'),
          (m) => iso(int.parse(m[3]!), _months[m[2]]!, int.parse(m[1]!))),
      (RegExp(r'\b(' + _months.keys.join('|') + r')[a-z]*\.?\s+(\d{1,2}),?\s+(\d{4})\b'),
          (m) => iso(int.parse(m[3]!), _months[m[1]]!, int.parse(m[2]!))),
    ];
    final seen = <int>{};
    for (final (re, toIso) in patterns) {
      for (final m in re.allMatches(f)) {
        if (!seen.add(m.start)) continue;
        final value = toIso(m);
        if (value.isNotEmpty) yield (start: m.start, end: m.end, iso: value);
      }
    }
  }

  static String _quote(String text, int start, int end) {
    final s = start.clamp(0, text.length);
    final e = end.clamp(s, text.length);
    return text.substring(s, e).replaceAll(RegExp(r'\s+'), ' ').trim();
  }

  /// Same folding as search, but guaranteed to keep offsets aligned.
  static String _fold(String s) {
    final out = StringBuffer();
    for (final unit in s.split('')) {
      final f = foldForSearch(unit);
      out.write(f.length == 1 ? f : (f.isEmpty ? ' ' : f[0]));
    }
    return out.toString();
  }
}

/// True if [quote] really occurs in [text], ignoring case, Turkish diacritics
/// and whitespace. Used to reject AI suggestions that cite text the document
/// doesn't contain.
bool quoteOccursIn(String quote, String text) {
  String norm(String s) => foldForSearch(s).replaceAll(RegExp(r'\s+'), ' ').trim();
  final q = norm(quote);
  return q.length >= 4 && norm(text).contains(q);
}
