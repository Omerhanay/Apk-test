# LIFE OS

*Ask. Remember. Act.* A private, local-first personal operating system for Android.

```
contracts/agent-tools.json   Tool contract shared by relay and app (single source of truth)
relay/                       Stateless LLM relay (Fastify + Anthropic SDK). Holds the API key.
app/                         Flutter Android app. Encrypted on-device DB, firewall, UI.
docs/adr/                    Architecture decisions
```

See [ADR 0001](docs/adr/0001-local-first-single-user-android.md) for the architecture and
[ADR 0002](docs/adr/0002-english-and-turkish.md) for languages (English, Turkish).

## Relay

```bash
cd relay
npm install
npm test
cp .env.example .env       # fill in values, see comments
LLM_PROVIDER=mock RELAY_TOKEN_SHA256=<hash> npm run dev   # no API key needed
```

Deploy with `docker build -f relay/Dockerfile .` from the repo root, behind HTTPS
(the app refuses non-https relay URLs). Secrets come from environment variables only.

## App

Requires Flutter 3.47+ and, to build an APK, the Android SDK.

```bash
cd app
flutter pub get
dart run build_runner build   # after changing tables.dart
flutter analyze && flutter test
flutter run                   # device or emulator
```

UI text lives in `lib/l10n/app_en.arb` and `app_tr.arb`; add every new string to both.

After editing `contracts/agent-tools.json`, copy it to `app/assets/contracts/`
(a test fails if they differ).

## Status

| Phase | State |
|---|---|
| 0 Repo, tooling | done |
| 2 Relay foundation | done |
| 3 App foundation: schema, encrypted DB, navigation, relay client | done |
| Localization: English + Turkish, language picker | done |
| 10 (core) Permission firewall + action state machine | done; grants editable in Settings |
| 4 Onboarding, app lock, relay pairing, permissions + activity screens | done |
| 5 Memory: capture (AI-assisted or offline), corrections with history, Turkish-aware search | done |
| 6 Tasks, events, reminders: EN/TR quick add, repeats, notifications, schema v2 migration | done |
| 7 Documents: encrypted files, on-device OCR, EN/TR classification and field extraction, verified AI suggestions, review → reminders, schema v3 | done |
| 8 AI retrieval: Ask My Life | next |
| 9-12 Agent loop, firewall UI, proactive, hardening | planned |
