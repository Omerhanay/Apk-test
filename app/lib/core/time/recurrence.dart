enum Frequency { daily, weekly, monthly, yearly }

/// The subset of RFC 5545 RRULE that LIFE OS creates: FREQ, INTERVAL and, for
/// monthly rules, BYMONTHDAY (so a task on the 31st stays at month end).
class Recurrence {
  const Recurrence(this.frequency, {this.interval = 1, this.monthDay}) : assert(interval > 0);

  final Frequency frequency;
  final int interval;
  final int? monthDay;

  static Recurrence? parse(String? rule) {
    if (rule == null || rule.isEmpty) return null;
    final parts = {
      for (final p in rule.split(';'))
        if (p.contains('=')) p.substring(0, p.indexOf('=')).toUpperCase(): p.substring(p.indexOf('=') + 1),
    };
    final freq = switch (parts['FREQ']?.toUpperCase()) {
      'DAILY' => Frequency.daily,
      'WEEKLY' => Frequency.weekly,
      'MONTHLY' => Frequency.monthly,
      'YEARLY' => Frequency.yearly,
      _ => null,
    };
    if (freq == null) return null;
    final interval = int.tryParse(parts['INTERVAL'] ?? '1') ?? 1;
    final monthDay = int.tryParse(parts['BYMONTHDAY'] ?? '');
    return Recurrence(freq, interval: interval < 1 ? 1 : interval, monthDay: monthDay);
  }

  String toRule() => [
        'FREQ=${frequency.name.toUpperCase()}',
        if (interval != 1) 'INTERVAL=$interval',
        if (monthDay != null) 'BYMONTHDAY=$monthDay',
      ].join(';');

  /// The occurrence after [from], keeping its wall-clock time.
  DateTime next(DateTime from) {
    DateTime at(int y, int m, int d) => DateTime(y, m, d, from.hour, from.minute, from.second);
    switch (frequency) {
      case Frequency.daily:
        return at(from.year, from.month, from.day + interval);
      case Frequency.weekly:
        return at(from.year, from.month, from.day + 7 * interval);
      case Frequency.monthly:
        final target = DateTime(from.year, from.month + interval);
        final day = _clamp(monthDay ?? from.day, target.year, target.month);
        return at(target.year, target.month, day);
      case Frequency.yearly:
        final year = from.year + interval;
        return at(year, from.month, _clamp(from.day, year, from.month));
    }
  }

  static int _clamp(int day, int year, int month) {
    final last = DateTime(year, month + 1, 0).day;
    return day > last ? last : day;
  }

  @override
  bool operator ==(Object other) =>
      other is Recurrence && other.frequency == frequency && other.interval == interval && other.monthDay == monthDay;

  @override
  int get hashCode => Object.hash(frequency, interval, monthDay);

  @override
  String toString() => toRule();
}
