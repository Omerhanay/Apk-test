# ADR 0003: Memory model

Status: accepted (2026-09-23)

## Decision
- A memory is one statement plus provenance (`source`, `sourceRef`,
  `confidence`, `sensitivity`). An optional key (`subject`, `predicate`, e.g.
  `user.vehicle` / `model`) identifies what the fact is about.
- **Corrections replace, never overwrite.** A new fact with the same key closes
  the old one (`validTo`, `supersededBy`); the old row keeps its content, so
  history is the chain of replaced facts plus `memory_versions` snapshots for
  edits and retractions.
- **"No longer true"** closes validity without deleting. **Delete** is a real
  erasure: the memory, its snapshots and the facts it replaced are removed.
  The audit log keeps only the id and action.
- **What the user said outranks the AI.** A fact written by the agent
  (`aiInferred`) can't replace a `userStated` fact with the same key; the tool
  returns `conflict_with_user_stated`. When the user confirms an AI-structured
  statement in the capture sheet, it is stored as `userStated`.
- **Capture:** with a relay, `/v1/memory/parse` (prompt `memory-parse.v1`,
  structured output) proposes category, key, validity and sensitivity; the user
  reviews before anything is saved. Only the text, the date, the language and
  the *keys* of existing facts are sent, never their contents. Without a relay,
  or if parsing fails, the user files it by hand.
- **Sensitivity** is the stricter of the AI's reading and the category default
  (health → special category).
- **Search** is local and Turkish-aware (`foldForSearch`: İ/I/ı/i and
  ç ğ ö ş ü folded). Full-text and semantic search come in Phase 8.
