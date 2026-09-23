# ADR 0005: Documents

Status: accepted (2026-09-23)

## Decision
- **Files are encrypted at rest** with AES-256-GCM (`EncryptedBlobStore`):
  a random nonce per file, a tag that detects tampering, and a file key held in
  Keystore-backed storage, separate from the database key. Duplicate imports
  are detected by SHA-256 of the plaintext.
- **Reading happens on the device.** PDF text comes from PDFium (pdfrx); pages
  with no text layer, and photos, go through Google ML Kit's on-device Latin
  recognizer. OCR needs the image as a file, so the rendered page is written to
  the app's private cache only for the duration of recognition, then deleted.
- **Classification and field extraction are deterministic rules** in English and
  Turkish. A date is classified (expiry, start, due, issue, renewal) only when a
  known label precedes it; unlabelled dates are not guessed. Every field keeps
  the passage it came from (`quote`) and who read it (`origin`).
- **AI is optional, text-only and verified.** With a relay, the user can ask for
  more fields. Only OCR text is sent, never the file. Each AI suggestion is kept
  only if its quote occurs in the document text, its key is known and a date is
  real; it never replaces a field the device already read.
- **Identity and health documents never go to the AI**: passport, ID card,
  driving licence and medical are `localOnlyDocumentTypes` in the app, and the
  relay independently refuses them with 422 without calling the model. The
  `search_documents` tool lists such documents by name only.
- **Nothing is committed without review.** Fields start as proposals; on Save,
  kept fields become an entity with `entity_dates`, and a future expiry or
  renewal becomes a reminder N days before (insurance 30, passport 180, …;
  payments 3). The agent only ever sees fields the user confirmed.
- **Delete is complete**: file, text, fields, entity, dates and reminders.
- **Schema v3** adds `documents.title`, `document_extractions.quote/origin` and
  an index on `document_chunks(document_id)`, with a migration test from v2.
