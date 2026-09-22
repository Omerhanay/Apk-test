# ADR 0002: English and Turkish

Status: accepted (2026-09-22). Supersedes the English-only choice in ADR 0001.

## Decision
- UI strings live in `app/lib/l10n/app_{en,tr}.arb` (Flutter gen-l10n). The app
  follows the device language; Settings → Language overrides it
  (System / English / Türkçe), stored in SharedPreferences. Unsupported device
  languages fall back to English.
- Dates and numbers are formatted with the active locale (`intl`).
- Uppercase labels are stored uppercased in the ARB files. Dart's
  `toUpperCase()` is not locale-aware (Turkish `i` must become `İ`).
- The agent prompt (`agent.v2`) replies in the language of the user's message
  and defines the "not enough information" reply in both languages.

## Consequences for later phases
- **Search (Phase 8):** SQLite FTS5 `unicode61` folds `İ` and `ı` incorrectly
  for Turkish. Normalise text with Turkish-aware case folding before indexing
  and querying, and test `İstanbul`/`istanbul`, `ılık`/`ILIK`.
- **Document extraction (Phase 7):** parse Turkish date formats
  (`22.09.2026`, `22 Eylül 2026`) and Turkish document vocabulary (poliçe,
  ruhsat, vade, bitiş tarihi).
- **Anti-hallucination evals:** run every case in both languages.
- Any new UI string needs both ARB entries; a test fails otherwise.
