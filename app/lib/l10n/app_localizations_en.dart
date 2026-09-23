// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get navToday => 'Today';

  @override
  String get navTasks => 'Tasks';

  @override
  String get navDocuments => 'Documents';

  @override
  String get navLife => 'Life';

  @override
  String get navMemory => 'Memory';

  @override
  String get askBarLabel => 'Ask or search your life';

  @override
  String get askHint => 'What am I forgetting?';

  @override
  String get askNotConnected =>
      'Asking is not connected yet. Once it is, answers will come only from what you have added, with sources.';

  @override
  String get settingsTooltip => 'Settings and privacy';

  @override
  String get greetingMorning => 'Good morning';

  @override
  String get greetingAfternoon => 'Good afternoon';

  @override
  String get greetingEvening => 'Good evening';

  @override
  String get todayHappening => 'HAPPENING';

  @override
  String get todayNothingScheduledTitle => 'Nothing scheduled';

  @override
  String get todayNothingScheduledBody =>
      'Events and tasks due today will appear here.';

  @override
  String get todayAttention => 'NEEDS ATTENTION';

  @override
  String get todayAllClearTitle => 'All clear';

  @override
  String get todayAllClearBody =>
      'Expiring documents, upcoming birthdays and open commitments will surface here, each with the reason why.';

  @override
  String get tasksTabToday => 'Today';

  @override
  String get tasksTabUpcoming => 'Upcoming';

  @override
  String get tasksTabSomeday => 'Someday';

  @override
  String get tasksEmptyTodayTitle => 'Nothing due today';

  @override
  String get tasksEmptyTodayBody =>
      'Tasks due today and overdue tasks appear here.';

  @override
  String get tasksEmptyUpcomingTitle => 'Nothing upcoming';

  @override
  String get tasksEmptyUpcomingBody =>
      'Tasks with a future due date appear here.';

  @override
  String get tasksEmptySomedayTitle => 'No someday tasks';

  @override
  String get tasksEmptySomedayBody => 'Tasks without a date appear here.';

  @override
  String get documentsEmptyTitle => 'No documents yet';

  @override
  String get documentsEmptyBody =>
      'Insurance, warranties, IDs and receipts you add are stored encrypted on this phone. Key dates are extracted for your review before any reminder is created.';

  @override
  String get lifeTabTimeline => 'Timeline';

  @override
  String get lifeTabPeople => 'People';

  @override
  String get lifeTabThings => 'Things';

  @override
  String get lifeTimelineEmptyTitle => 'Your timeline is empty';

  @override
  String get lifeTimelineEmptyBody =>
      'Events, uploads and reminders appear here in order.';

  @override
  String get lifePeopleEmptyTitle => 'No people yet';

  @override
  String get lifePeopleEmptyBody =>
      'People you mention, like family members, are linked here.';

  @override
  String get lifeThingsEmptyTitle => 'No things yet';

  @override
  String get lifeThingsEmptyBody =>
      'Vehicles, subscriptions and trips are linked here.';

  @override
  String get memoryEmptyTitle => 'LIFE OS knows nothing yet';

  @override
  String get memoryEmptyBody =>
      'Tell LIFE OS about your life with the + button. Everything it remembers is listed here with where it came from, and you can edit or delete any of it.';

  @override
  String get settingsTitle => 'Settings & privacy';

  @override
  String get settingsTrust => 'TRUST';

  @override
  String get settingsPermissions => 'Permissions';

  @override
  String get settingsPermissionsSub => 'What LIFE OS may read and do';

  @override
  String get settingsActivity => 'Activity';

  @override
  String get settingsActivitySub => 'Audit trail of every action';

  @override
  String get settingsConnection => 'CONNECTION';

  @override
  String get settingsRelay => 'AI relay';

  @override
  String get settingsRelayNotConfigured => 'Not configured';

  @override
  String get settingsSafety => 'SAFETY';

  @override
  String get settingsEmergency => 'Emergency card';

  @override
  String get settingsEmergencySub => 'Choose exactly what is shown';

  @override
  String get settingsYourData => 'YOUR DATA';

  @override
  String get settingsExport => 'Export everything';

  @override
  String get settingsDelete => 'Delete all data';

  @override
  String get settingsPreferences => 'PREFERENCES';

  @override
  String get settingsLanguage => 'Language';

  @override
  String get languageSystem => 'System default';

  @override
  String get onboardingTitle => 'Welcome to LIFE OS';

  @override
  String get onboardingPrivate => 'Your data stays on this phone, encrypted.';

  @override
  String get onboardingAsks =>
      'It asks before it acts, and shows you what it will do.';

  @override
  String get onboardingSources =>
      'Answers come only from what you add, with sources.';

  @override
  String get onboardingContinue => 'Set up app lock';

  @override
  String get lockReason => 'Unlock LIFE OS';

  @override
  String get lockTitle => 'LIFE OS is locked';

  @override
  String get lockUnlock => 'Unlock';

  @override
  String get lockNoCredential =>
      'Set a screen lock (PIN, pattern, password or fingerprint) in Android settings to use LIFE OS. It protects your data if the phone is lost.';

  @override
  String get lockLockedOut =>
      'Too many attempts. Wait a moment, then try again.';

  @override
  String get lockFailed => 'Couldn\'t unlock. Try again.';

  @override
  String get relayExplain =>
      'LIFE OS reaches the AI through your own relay server, which holds the API key. Your data stays on this phone; only what a question needs is sent.';

  @override
  String get relayUrl => 'Relay address';

  @override
  String get relayToken => 'Device token';

  @override
  String get relayTestAndSave => 'Test and save';

  @override
  String get relayConnected => 'Connected';

  @override
  String get relayRemove => 'Disconnect';

  @override
  String get relayErrorHttps => 'The address must start with https://';

  @override
  String get relayErrorToken => 'The token must be at least 32 characters.';

  @override
  String get relayErrorUnauthorized => 'The relay rejected this token.';

  @override
  String get relayErrorOffline =>
      'Couldn\'t reach the relay. Check the address and your connection.';

  @override
  String relayErrorOther(String code) {
    return 'The relay returned an error ($code).';
  }

  @override
  String get relaySaved => 'Relay connected';

  @override
  String get permissionsExplain =>
      'Turn off anything you don\'t want LIFE OS to use. Actions set to \"Ask me first\" always show a preview for your approval.';

  @override
  String get permissionsRead => 'WHAT IT CAN SEE';

  @override
  String get permissionsAct => 'WHAT IT CAN DO';

  @override
  String get permissionAskFirst => 'Ask me first';

  @override
  String get capReadMemory => 'Your memories';

  @override
  String get capReadDocuments => 'Your documents';

  @override
  String get capReadTasks => 'Your tasks';

  @override
  String get capReadCalendar => 'Your calendar';

  @override
  String get capCreateTask => 'Create tasks';

  @override
  String get capCreateReminder => 'Create reminders';

  @override
  String get capCreateEvent => 'Create events';

  @override
  String get capWriteMemory => 'Remember and correct facts';

  @override
  String get activityEmptyTitle => 'No activity yet';

  @override
  String get activityEmptyBody =>
      'Permission changes, unlocks and every action LIFE OS takes are recorded here.';

  @override
  String get auditAppUnlocked => 'App unlocked';

  @override
  String get auditPermissionsSeeded => 'Default permissions set';

  @override
  String get auditPermissionGranted => 'Permission turned on';

  @override
  String get auditPermissionRevoked => 'Permission turned off';

  @override
  String get auditAskFirstOn => '\"Ask me first\" turned on';

  @override
  String get auditAskFirstOff => '\"Ask me first\" turned off';

  @override
  String get auditRelayPaired => 'Relay connected';

  @override
  String get auditRelayRemoved => 'Relay disconnected';

  @override
  String get memoryAdd => 'Add memory';

  @override
  String get memoryCaptureHint => 'Tell LIFE OS something about your life';

  @override
  String get memoryCaptureExample =>
      'e.g. My car is a BYD Seal U. I prefer morning flights.';

  @override
  String get memoryOrganizeWithAi => 'Organize with AI';

  @override
  String get memoryOrganizeNote =>
      'The text is sent to your AI relay to categorize it.';

  @override
  String get memoryContinue => 'Continue';

  @override
  String get memorySave => 'Save';

  @override
  String get memoryCategory => 'Category';

  @override
  String get memoryPreviewTitle => 'LIFE OS will remember';

  @override
  String get memoryRetractPreviewTitle => 'Mark as no longer true';

  @override
  String get memoryRetractNoMatch =>
      'No matching memory was found. You can save this as a new note instead.';

  @override
  String get memorySaveAsNote => 'Save as note';

  @override
  String memoryReplaces(String old) {
    return 'Replaces: $old';
  }

  @override
  String get memoryAiUnavailable =>
      'Couldn\'t organize it with AI. You can save it as written.';

  @override
  String get memorySpecialCategoryNote =>
      'Marked as highly sensitive. It stays encrypted on this phone.';

  @override
  String get memoryRemembered => 'Remembered';

  @override
  String get memoryUpdatedKeepsHistory =>
      'Updated. The previous version is kept in history.';

  @override
  String get memoryMarkedNotTrue => 'Marked as no longer true';

  @override
  String get memoryDeleted => 'Deleted';

  @override
  String get memorySearchHint => 'Search memories';

  @override
  String get memoryNoResults => 'No memories match.';

  @override
  String get memorySourceUser => 'You told LIFE OS';

  @override
  String get memorySourceDocument => 'From a document';

  @override
  String get memorySourceAi => 'Suggested by AI';

  @override
  String get memorySourceIntegration => 'From a connected app';

  @override
  String get memorySourceSystem => 'Added by LIFE OS';

  @override
  String memoryValidUntil(String date) {
    return 'Valid until $date';
  }

  @override
  String memoryEndedOn(String date) {
    return 'No longer true since $date';
  }

  @override
  String memoryRecordedOn(String date) {
    return 'Recorded $date';
  }

  @override
  String get memoryHistory => 'HISTORY';

  @override
  String get memoryHistoryEmpty => 'No earlier versions.';

  @override
  String get memoryHistoryEdited => 'Before editing';

  @override
  String get memoryHistoryReplaced => 'Replaced';

  @override
  String get memoryHistoryRetracted => 'Marked no longer true';

  @override
  String get memoryEdit => 'Edit';

  @override
  String get memoryNoLongerTrue => 'No longer true';

  @override
  String get memoryDelete => 'Delete';

  @override
  String get memoryDeleteConfirmTitle => 'Delete this memory?';

  @override
  String get memoryDeleteConfirmBody =>
      'It will be removed from this phone with its history. This can\'t be undone.';

  @override
  String get memoryCancel => 'Cancel';

  @override
  String get catFamily => 'Family';

  @override
  String get catVehicle => 'Vehicle';

  @override
  String get catHome => 'Home';

  @override
  String get catHealth => 'Health';

  @override
  String get catWork => 'Work';

  @override
  String get catFinance => 'Finance';

  @override
  String get catTravel => 'Travel';

  @override
  String get catPreference => 'Preferences';

  @override
  String get catRoutine => 'Routines';

  @override
  String get catOther => 'Other';

  @override
  String get auditMemoryCreated => 'Memory added';

  @override
  String get auditMemoryEdited => 'Memory edited';

  @override
  String get auditMemoryRetracted => 'Memory marked no longer true';

  @override
  String get auditMemorySuperseded => 'Memory replaced by a newer one';

  @override
  String get auditMemoryDeleted => 'Memory deleted';
}
