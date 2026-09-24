import '../../core/db/tables.dart' show Source;
import 'package:intl/intl.dart';

import '../../core/life/life_repository.dart' show ReminderTitle;
import '../../core/time/recurrence.dart';
import '../../l10n/app_localizations.dart';

/// User-facing names for permission capabilities. Unknown codes are shown as-is
/// so a new capability is never silently hidden from the permissions screen.
String capabilityLabel(AppLocalizations l, String capability) => switch (capability) {
      'READ_MEMORY' => l.capReadMemory,
      'READ_DOCUMENTS' => l.capReadDocuments,
      'READ_TASKS' => l.capReadTasks,
      'READ_CALENDAR' => l.capReadCalendar,
      'CREATE_TASK' => l.capCreateTask,
      'CREATE_REMINDER' => l.capCreateReminder,
      'CREATE_EVENT' => l.capCreateEvent,
      'WRITE_MEMORY' => l.capWriteMemory,
      _ => capability,
    };

String auditActionLabel(AppLocalizations l, String action) => switch (action) {
      'app_unlocked' => l.auditAppUnlocked,
      'permissions_seeded' => l.auditPermissionsSeeded,
      'permission_granted' => l.auditPermissionGranted,
      'permission_revoked' => l.auditPermissionRevoked,
      'ask_first_on' => l.auditAskFirstOn,
      'ask_first_off' => l.auditAskFirstOff,
      'relay_paired' => l.auditRelayPaired,
      'relay_removed' => l.auditRelayRemoved,
      'memory_created' => l.auditMemoryCreated,
      'memory_edited' => l.auditMemoryEdited,
      'memory_retracted' => l.auditMemoryRetracted,
      'memory_superseded' => l.auditMemorySuperseded,
      'memory_deleted' => l.auditMemoryDeleted,
      'task_created' => l.auditTaskCreated,
      'task_completed' => l.auditTaskCompleted,
      'task_reopened' => l.auditTaskReopened,
      'task_edited' => l.auditTaskEdited,
      'task_deleted' => l.auditTaskDeleted,
      'event_created' => l.auditEventCreated,
      'event_deleted' => l.auditEventDeleted,
      'reminder_created' => l.auditReminderCreated,
      'document_added' => l.auditDocumentAdded,
      'document_reviewed' => l.auditDocumentReviewed,
      'document_deleted' => l.auditDocumentDeleted,
      'document_ai_fields' => l.auditDocumentAiFields,
      'person_added' => l.auditPersonAdded,
      'person_edited' => l.auditPersonEdited,
      'person_deleted' => l.auditPersonDeleted,
      'thing_added' => l.auditThingAdded,
      'thing_edited' => l.auditThingEdited,
      'thing_deleted' => l.auditThingDeleted,
      'date_added' => l.auditDateAdded,
      _ => action,
    };

String memoryCategoryLabel(AppLocalizations l, String category) => switch (category) {
      'family' => l.catFamily,
      'vehicle' => l.catVehicle,
      'home' => l.catHome,
      'health' => l.catHealth,
      'work' => l.catWork,
      'finance' => l.catFinance,
      'travel' => l.catTravel,
      'preference' => l.catPreference,
      'routine' => l.catRoutine,
      _ => l.catOther,
    };

String memorySourceLabel(AppLocalizations l, Source source) => switch (source) {
      Source.userStated => l.memorySourceUser,
      Source.document => l.memorySourceDocument,
      Source.aiInferred => l.memorySourceAi,
      Source.integration => l.memorySourceIntegration,
      Source.system => l.memorySourceSystem,
    };

String recurrenceLabel(AppLocalizations l, Recurrence? r) {
  if (r == null) return l.repeatNone;
  if (r.frequency == Frequency.daily && r.interval > 1) return l.repeatEveryNDays(r.interval);
  return switch (r.frequency) {
    Frequency.daily => l.repeatDaily,
    Frequency.weekly => l.repeatWeekly,
    Frequency.monthly => l.repeatMonthly,
    Frequency.yearly => l.repeatYearly,
  };
}

/// "Today 09:00", "Tomorrow", "Fri 2 Oct 14:30" in the active locale.
String dueLabel(AppLocalizations l, String locale, DateTime due, {required bool allDay, required DateTime now}) {
  // UTC dates: a local day across a DST change can be 23 or 25 hours long.
  final day = DateTime.utc(due.year, due.month, due.day);
  final today = DateTime.utc(now.year, now.month, now.day);
  final dayPart = switch (day.difference(today).inDays) {
    0 => l.dueToday,
    1 => l.dueTomorrow,
    -1 => l.dueYesterday,
    _ => DateFormat.MMMEd(locale).format(due),
  };
  return allDay ? dayPart : '$dayPart ${DateFormat.Hm(locale).format(due)}';
}

String documentFieldLabel(AppLocalizations l, String key) => switch (key) {
      'expires_on' => l.fieldExpiresOn,
      'starts_on' => l.fieldStartsOn,
      'due_on' => l.fieldDueOn,
      'issued_on' => l.fieldIssuedOn,
      'renews_on' => l.fieldRenewsOn,
      'policy_number' => l.fieldPolicyNumber,
      'provider' => l.fieldProvider,
      'vehicle_plate' => l.fieldVehiclePlate,
      'vehicle_model' => l.fieldVehicleModel,
      'amount' => l.fieldAmount,
      'reference' => l.fieldReference,
      _ => key,
    };

String documentTypeLabel(AppLocalizations l, String? type) => switch (type) {
      'insurance' => l.docTypeInsurance,
      'vehicle_registration' => l.docTypeVehicleRegistration,
      'passport' => l.docTypePassport,
      'id_card' => l.docTypeIdCard,
      'driver_license' => l.docTypeDriverLicense,
      'warranty' => l.docTypeWarranty,
      'invoice' => l.docTypeInvoice,
      'receipt' => l.docTypeReceipt,
      'contract' => l.docTypeContract,
      'travel' => l.docTypeTravel,
      'medical' => l.docTypeMedical,
      _ => l.docTypeOther,
    };

String relationLabel(AppLocalizations l, String? r) => switch (r) {
      'spouse' => l.relSpouse,
      'child' => l.relChild,
      'parent' => l.relParent,
      'sibling' => l.relSibling,
      'relative' => l.relRelative,
      'friend' => l.relFriend,
      'colleague' => l.relColleague,
      _ => l.relOther,
    };

String thingTypeLabel(AppLocalizations l, String? t) => switch (t) {
      'vehicle' => l.thingVehicle,
      'home' => l.thingHome,
      'subscription' => l.thingSubscription,
      'device' => l.thingDevice,
      'pet' => l.thingPet,
      _ => l.thingOther,
    };

/// Entity date kinds, including the ones documents create (expires, starts, …).
String dateKindLabel(AppLocalizations l, String? k) => switch (k) {
      'birthday' => l.dateKindBirthday,
      'expires' => l.dateKindExpires,
      'renews' => l.dateKindRenews,
      'inspection' => l.dateKindInspection,
      'service' => l.dateKindService,
      'payment' => l.dateKindPayment,
      'starts' => l.dateKindStarts,
      'issued' => l.dateKindIssued,
      'due' => l.dateKindDue,
      _ => l.dateKindOther,
    };

/// Localized reminder titles for people's and things' dates.
ReminderTitle lifeReminderTitle(AppLocalizations l, String locale) =>
    (name, kind, occurrence) => l.lifeReminderTitle(name, dateKindLabel(l, kind), DateFormat.MMMMd(locale).format(occurrence));
