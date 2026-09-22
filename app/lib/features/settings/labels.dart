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
      _ => action,
    };
