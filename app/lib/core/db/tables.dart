import 'package:drift/drift.dart';

// Schema v1 of the on-device system of record.
//
// Conventions shared by user-data tables:
//  * text UUIDv7 primary keys (time-sortable, generated on device)
//  * `source` + `sourceRef` record provenance; `confidence` is 0..1
//  * `sensitivity` gates what may leave the device (see ContextPolicy)
//  * soft delete via `deletedAt`, purged by a maintenance job

enum Source { userStated, document, integration, aiInferred, system }

enum Sensitivity { normal, personal, sensitive, specialCategory }

enum MemoryKind { semantic, episodic, procedural, temporal }

enum TaskStatus { open, done, cancelled }

enum Priority { low, normal, high }

enum ReviewStatus { pending, accepted, rejected, edited }

enum ActionState { proposed, awaitingApproval, approved, rejected, blocked, executing, verified, failed }

mixin Provenance on Table {
  TextColumn get id => text()();
  IntColumn get source => intEnum<Source>()();
  TextColumn get sourceRef => text().nullable()();
  RealColumn get confidence => real().withDefault(const Constant(1.0))();
  IntColumn get sensitivity => intEnum<Sensitivity>().withDefault(const Constant(0))();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
  DateTimeColumn get deletedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('Memory')
class Memories extends Table with Provenance {
  IntColumn get kind => intEnum<MemoryKind>()();
  TextColumn get category => text()();
  TextColumn get content => text()();

  /// Normalized subject/predicate let corrections supersede the right fact,
  /// e.g. ("user.vehicle", "model").
  TextColumn get subject => text().nullable()();
  TextColumn get predicate => text().nullable()();
  TextColumn get value => text().nullable()();
  DateTimeColumn get validFrom => dateTime()();
  DateTimeColumn get validTo => dateTime().nullable()();
  TextColumn get supersededBy => text().nullable().references(Memories, #id)();
  BoolColumn get userEditable => boolean().withDefault(const Constant(true))();
  IntColumn get version => integer().withDefault(const Constant(1))();
}

@DataClassName('MemoryVersion')
class MemoryVersions extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get memoryId => text().references(Memories, #id)();
  IntColumn get version => integer()();
  TextColumn get content => text()();
  TextColumn get value => text().nullable()();
  DateTimeColumn get validTo => dateTime().nullable()();
  TextColumn get changedBy => text()(); // user | ai | system
  TextColumn get changeReason => text().nullable()();
  DateTimeColumn get at => dateTime()();
}

/// Long-tail typed things (Person, Vehicle, Insurance, Subscription, Trip...).
/// Type-specific attributes live in [attributes] as JSON validated per type;
/// anything time-critical goes to [EntityDates] instead.
@DataClassName('Entity')
class Entities extends Table with Provenance {
  TextColumn get type => text()();
  TextColumn get displayName => text()();
  TextColumn get attributes => text().withDefault(const Constant('{}'))();
}

@DataClassName('EntityRelationship')
class EntityRelationships extends Table with Provenance {
  @ReferenceName('outgoingRelationships')
  TextColumn get fromEntity => text().references(Entities, #id)();
  @ReferenceName('incomingRelationships')
  TextColumn get toEntity => text().references(Entities, #id)();
  TextColumn get relation => text()(); // e.g. insures, owns, child_of
  DateTimeColumn get validFrom => dateTime().nullable()();
  DateTimeColumn get validTo => dateTime().nullable()();
}

/// Every date the proactive engine reasons about, in one indexed table.
@DataClassName('EntityDate')
class EntityDates extends Table with Provenance {
  TextColumn get entityId => text().references(Entities, #id)();
  TextColumn get kind => text()(); // starts | expires | renews | due | birthday | anniversary
  DateTimeColumn get date => dateTime()();
  TextColumn get recurrenceRule => text().nullable()(); // RFC 5545 RRULE
}

@DataClassName('Document')
class Documents extends Table with Provenance {
  TextColumn get fileName => text()();

  /// Schema v3: a readable name, e.g. "Kasko poliçesi – Anadolu Sigorta".
  TextColumn get title => text().nullable()();
  TextColumn get mimeType => text()();
  TextColumn get sha256 => text()();
  IntColumn get sizeBytes => integer()();

  /// Path of the encrypted blob inside the app's private storage.
  TextColumn get blobPath => text()();
  TextColumn get docType => text().nullable()();
  RealColumn get classificationConfidence => real().nullable()();
  TextColumn get ocrStatus => text().withDefault(const Constant('pending'))();
  TextColumn get extractionStatus => text().withDefault(const Constant('pending'))();
  TextColumn get entityId => text().nullable().references(Entities, #id)();
}

@DataClassName('DocumentExtraction')
class DocumentExtractions extends Table {
  TextColumn get id => text()();
  TextColumn get documentId => text().references(Documents, #id)();
  TextColumn get field => text()();
  TextColumn get value => text()();
  RealColumn get confidence => real()();
  IntColumn get page => integer().nullable()();
  IntColumn get reviewStatus => intEnum<ReviewStatus>().withDefault(const Constant(0))();

  /// Schema v3: the passage the value was read from, and who read it (local | ai).
  TextColumn get quote => text().nullable()();
  TextColumn get origin => text().withDefault(const Constant('local'))();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('DocumentChunk')
class DocumentChunks extends Table {
  TextColumn get id => text()();
  TextColumn get documentId => text().references(Documents, #id)();
  IntColumn get ordinal => integer()();
  TextColumn get body => text()();
  IntColumn get page => integer().nullable()();

  /// Float32 embedding as bytes; null for sensitive content, which is never embedded remotely.
  BlobColumn get embedding => blob().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('Task')
class Tasks extends Table with Provenance {
  TextColumn get title => text()();
  TextColumn get notes => text().nullable()();
  IntColumn get status => intEnum<TaskStatus>().withDefault(const Constant(0))();
  IntColumn get priority => intEnum<Priority>().withDefault(const Constant(1))();
  DateTimeColumn get dueAt => dateTime().nullable()();

  /// Schema v2: due on a date without a specific time.
  BoolColumn get allDay => boolean().withDefault(const Constant(false))();
  TextColumn get recurrenceRule => text().nullable()();
  TextColumn get projectEntityId => text().nullable().references(Entities, #id)();
  DateTimeColumn get completedAt => dateTime().nullable()();
}

@DataClassName('Event')
class Events extends Table with Provenance {
  TextColumn get title => text()();
  DateTimeColumn get startsAt => dateTime()();
  DateTimeColumn get endsAt => dateTime().nullable()();
  TextColumn get location => text().nullable()();
  TextColumn get recurrenceRule => text().nullable()();
  TextColumn get externalRef => text().nullable()();
}

@DataClassName('Reminder')
class Reminders extends Table with Provenance {
  TextColumn get title => text()();
  DateTimeColumn get fireAt => dateTime()();

  /// Id of the linked task/event/document/memory/entity, if any.
  TextColumn get targetId => text().nullable()();
  TextColumn get status => text().withDefault(const Constant('scheduled'))(); // scheduled | fired | dismissed
  DateTimeColumn get snoozedUntil => dateTime().nullable()();
}

@DataClassName('Commitment')
class Commitments extends Table with Provenance {
  TextColumn get description => text()();
  TextColumn get counterparty => text().nullable()();
  DateTimeColumn get dueAt => dateTime().nullable()();
  TextColumn get status => text().withDefault(const Constant('open'))();
  TextColumn get taskId => text().nullable().references(Tasks, #id)();
}

@DataClassName('PermissionGrantRow')
class Permissions extends Table {
  TextColumn get capability => text()();
  BoolColumn get granted => boolean()();

  /// When true, low/medium-risk commits under this capability run without a
  /// per-action approval. Ignored for high-risk capabilities.
  BoolColumn get autonomous => boolean().withDefault(const Constant(false))();
  TextColumn get scope => text().withDefault(const Constant('{}'))();
  TextColumn get grantedVia => text()(); // default | user
  DateTimeColumn get grantedAt => dateTime()();
  DateTimeColumn get expiresAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {capability};
}

@DataClassName('AgentRun')
class AgentRuns extends Table {
  TextColumn get id => text()();
  TextColumn get trigger => text()(); // chat | proactive
  TextColumn get model => text().nullable()();
  TextColumn get promptVersion => text().nullable()();
  IntColumn get inputTokens => integer().withDefault(const Constant(0))();
  IntColumn get outputTokens => integer().withDefault(const Constant(0))();
  IntColumn get latencyMs => integer().nullable()();
  TextColumn get status => text()();
  DateTimeColumn get startedAt => dateTime()();
  DateTimeColumn get finishedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('AgentActionRow')
class AgentActions extends Table {
  TextColumn get id => text()();
  TextColumn get runId => text().references(AgentRuns, #id)();
  TextColumn get tool => text()();
  TextColumn get args => text()();
  TextColumn get argsHash => text()();
  TextColumn get risk => text()();
  IntColumn get state => intEnum<ActionState>()();
  TextColumn get blockReason => text().nullable()();
  TextColumn get resultRef => text().nullable()();
  TextColumn get errorCode => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get decidedAt => dateTime().nullable()();
  DateTimeColumn get completedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

/// Proactive "what am I forgetting?" items with the facts that triggered them.
@DataClassName('Suggestion')
class Suggestions extends Table {
  TextColumn get id => text()();
  TextColumn get detector => text()();
  TextColumn get subjectId => text()();
  TextColumn get reasonCode => text()();
  TextColumn get explanationFacts => text()(); // JSON list of {table, id}
  DateTimeColumn get dueAt => dateTime().nullable()();
  DateTimeColumn get surfacedAt => dateTime()();
  DateTimeColumn get dismissedAt => dateTime().nullable()();
  DateTimeColumn get snoozedUntil => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

/// Append-only. Holds references and outcomes, never personal content.
@DataClassName('AuditEntry')
class AuditLogs extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get actor => text()(); // user | agent | system
  TextColumn get action => text()();
  TextColumn get targetType => text().nullable()();
  TextColumn get targetId => text().nullable()();
  TextColumn get outcome => text()();
  DateTimeColumn get at => dateTime()();
}

/// User-curated emergency card. Each field is opt-in.
@DataClassName('EmergencyField')
class EmergencyFields extends Table {
  TextColumn get key => text()(); // contacts | allergies | medications | conditions | insurance | notes
  TextColumn get value => text()();
  BoolColumn get showOnCard => boolean().withDefault(const Constant(false))();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {key};
}
