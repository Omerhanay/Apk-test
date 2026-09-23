# ADR 0004: Tasks, events and reminders

Status: accepted (2026-09-23)

## Decision
- **Quick add is deterministic.** `QuickAddParser` reads dates, times and
  repetition from English and Turkish phrases with fixed rules (no AI), so it
  works offline and never invents a date. Impossible dates (31.02) are ignored,
  not rolled over. The parsed title, date and repetition are previewed and can
  be changed before saving. Weekday rules: a bare weekday is the next one after
  today; "this/bu" may be today; "next/haftaya/gelecek" is that day in the
  following Monday-based week. Times without am/pm are read as 24-hour.
- **Repeats** use a small RRULE subset (FREQ, INTERVAL, BYMONTHDAY). Completing a
  repeating task creates the next occurrence from the previous *due* date,
  skipping occurrences already in the past; Undo removes it again.
- **Reminders** are rows in `reminders` plus an OS notification. Timed tasks are
  reminded at the due time, all-day tasks at 09:00, events 15 minutes before.
  Past reminders are recorded but never scheduled. Notifications use inexact
  alarms (no exact-alarm permission; may arrive a few minutes late on an idle
  phone), private lock-screen visibility, and survive reboots via the plugin's
  boot receiver. Permission is requested only when the first reminder is set.
- **Schema v2** adds `tasks.all_day`. The migration test builds a real v1
  database from `test/db/fixtures/schema_v1.sql` and upgrades it; every future
  schema change must add a fixture and a test the same way.
