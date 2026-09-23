import 'package:flutter_test/flutter_test.dart';
import 'package:life_os/core/time/quick_add_parser.dart';
import 'package:life_os/core/time/recurrence.dart';

void main() {
  // Wednesday 23 September 2026, 10:00.
  final now = DateTime(2026, 9, 23, 10);
  const parser = QuickAddParser();
  QuickAddResult p(String s) => parser.parse(s, now);

  group('English', () {
    test('tomorrow with a time', () {
      final r = p('Call insurance tomorrow at 9am');
      expect(r.title, 'Call insurance');
      expect(r.due, DateTime(2026, 9, 24, 9));
      expect(r.allDay, isFalse);
    });

    test('date only is all-day', () {
      final r = p('Dentist 22.10.2026');
      expect(r.title, 'Dentist');
      expect(r.due, DateTime(2026, 10, 22));
      expect(r.allDay, isTrue);
    });

    test('month names, with and without year', () {
      expect(p('Renew passport Oct 5').due, DateTime(2026, 10, 5));
      expect(p('Party on 4 June').due, DateTime(2027, 6, 4), reason: 'already passed this year');
      expect(p('Launch March 3, 2027').due, DateTime(2027, 3, 3));
    });

    test('weekdays: bare, this and next', () {
      expect(p('gym friday').due, DateTime(2026, 9, 25));
      expect(p('review wednesday').due, DateTime(2026, 9, 30), reason: 'bare weekday is never today');
      expect(p('review this wednesday').due, DateTime(2026, 9, 23));
      expect(p('meet next monday').due, DateTime(2026, 9, 28));
    });

    test('relative offsets and times', () {
      expect(p('follow up in 3 days').due, DateTime(2026, 9, 26));
      expect(p('water plants tonight').due, DateTime(2026, 9, 23, 20));
      expect(p('standup 9:30').due, DateTime(2026, 9, 24, 9, 30), reason: '9:30 has passed today');
      expect(p('lunch at 13').due, DateTime(2026, 9, 23, 13));
      expect(p('call mom 7pm').due, DateTime(2026, 9, 23, 19));
    });

    test('repetition', () {
      final r = p('every monday gym');
      expect(r.title, 'gym');
      expect(r.recurrence, const Recurrence(Frequency.weekly));
      expect(r.due, DateTime(2026, 9, 28));
      expect(p('take vitamins daily at 8am').recurrence, const Recurrence(Frequency.daily));
      expect(p('pay rent monthly 1.10.2026').recurrence, const Recurrence(Frequency.monthly, monthDay: 1));
    });
  });

  group('Turkish', () {
    test("yarın 9'da", () {
      final r = p("Yarın 9'da sigortayı ara");
      expect(r.title, 'sigortayı ara');
      expect(r.due, DateTime(2026, 9, 24, 9));
    });

    test('dotted capital İ and suffixes', () {
      final r = p('YARIN SAAT 14:30 TOPLANTI');
      expect(r.due, DateTime(2026, 9, 24, 14, 30));
      expect(r.title, 'TOPLANTI');
      expect(p("Cumaya kadar raporu bitir").due, DateTime(2026, 9, 25));
    });

    test('weekday names do not swallow longer ones', () {
      expect(p('cumartesi pazar alışverişi').due, DateTime(2026, 9, 26));
      expect(p('pazartesi toplantı').due, DateTime(2026, 9, 28));
      expect(p('salata malzemesi al').due, isNull, reason: '"salata" is not "salı"');
    });

    test('next week and parts of the day', () {
      expect(p('haftaya salı dişçi').due, DateTime(2026, 9, 29));
      expect(p('akşam 7 annemi ara').due, DateTime(2026, 9, 23, 19));
      expect(p('sabah 8 koşu').due, DateTime(2026, 9, 24, 8));
      expect(p('bu akşam çiçekleri sula').due, DateTime(2026, 9, 23, 20));
    });

    test('month names and offsets', () {
      expect(p('4 Haziran doğum günü').due, DateTime(2027, 6, 4));
      expect(p('22 Ekim kasko yenile').due, DateTime(2026, 10, 22));
      expect(p('3 gün sonra geri dön').due, DateTime(2026, 9, 26));
      expect(p('öbür gün kargo').due, DateTime(2026, 9, 25));
    });

    test('repetition', () {
      final r = p('her pazartesi spor');
      expect(r.title, 'spor');
      expect(r.recurrence, const Recurrence(Frequency.weekly));
      expect(r.due, DateTime(2026, 9, 28));
      expect(p('her gün ilaç 09:00').recurrence, const Recurrence(Frequency.daily));
    });
  });

  test('no date or time leaves the task undated and the text untouched', () {
    final r = p('Buy milk');
    expect(r.title, 'Buy milk');
    expect(r.due, isNull);
    expect(r.recurrence, isNull);
  });

  test('impossible dates are ignored rather than rolled over', () {
    final r = p('Report 31.02.2027');
    expect(r.due, isNull);
  });

  group('Recurrence', () {
    test('monthly on the 31st clamps to month end and returns to the 31st', () {
      const rule = Recurrence(Frequency.monthly, monthDay: 31);
      final feb = rule.next(DateTime(2027, 1, 31, 9));
      expect(feb, DateTime(2027, 2, 28, 9));
      expect(rule.next(feb), DateTime(2027, 3, 31, 9));
    });

    test('yearly on 29 February', () {
      expect(const Recurrence(Frequency.yearly).next(DateTime(2028, 2, 29)), DateTime(2029, 2, 28));
    });

    test('round-trips RRULE text', () {
      const r = Recurrence(Frequency.daily, interval: 3);
      expect(r.toRule(), 'FREQ=DAILY;INTERVAL=3');
      expect(Recurrence.parse(r.toRule()), r);
      expect(Recurrence.parse('FREQ=HOURLY'), isNull);
    });
  });
}
