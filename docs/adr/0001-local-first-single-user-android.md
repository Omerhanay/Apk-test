# ADR 0001: Local-first, single-user, Android-only

Status: accepted (2026-09-22)

## Context
LIFE OS is used by a single person on one Android phone. The original design
assumed multi-user accounts, households, a server-side Postgres system of
record and sync.

## Decision
- The phone is the system of record: Drift over SQLite3MultipleCiphers,
  encrypted with a 256-bit key held in Android Keystore-backed storage.
- No accounts, households, row-level security or server sync.
- A small stateless **relay** (Node/TypeScript) holds the LLM API key and
  forwards one agent turn at a time. It stores nothing and never logs content.
- Agent tools run **on the device**. The relay only sees what the app sends:
  the conversation and tool results the app chose to return.
- The permission firewall, action state machine and audit log live on-device.
  Approval is a UI event; no model-callable tool can approve anything.
- The relay speaks a provider-neutral block format, so switching LLM providers
  only touches `relay/src/llm/`.

## Consequences
- Offline works for everything except asking the AI.
- Losing the phone loses data unless the user makes an encrypted export (planned).
- Anything sent to the relay goes to the LLM provider. A context policy must
  keep `special_category` data (health, ID numbers) out unless it is needed.

## App lock (Phase 4)
- The app locks at launch and after 30 s in the background. Unlocking uses
  Android BiometricPrompt with device-credential fallback; a phone without a
  screen lock cannot use the app.
- The database is opened only after unlock. The database key is stored with
  flutter_secure_storage (Keystore-wrapped) but is **not** bound to user
  authentication at the Keystore level, so the lock is an app-level gate.
  Binding the key to authentication (`setUserAuthenticationRequired`) is a
  Phase 12 hardening item.
