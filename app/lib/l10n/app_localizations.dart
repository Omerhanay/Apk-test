import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_tr.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('tr'),
  ];

  /// No description provided for @navToday.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get navToday;

  /// No description provided for @navTasks.
  ///
  /// In en, this message translates to:
  /// **'Tasks'**
  String get navTasks;

  /// No description provided for @navDocuments.
  ///
  /// In en, this message translates to:
  /// **'Documents'**
  String get navDocuments;

  /// No description provided for @navLife.
  ///
  /// In en, this message translates to:
  /// **'Life'**
  String get navLife;

  /// No description provided for @navMemory.
  ///
  /// In en, this message translates to:
  /// **'Memory'**
  String get navMemory;

  /// No description provided for @askBarLabel.
  ///
  /// In en, this message translates to:
  /// **'Ask or search your life'**
  String get askBarLabel;

  /// No description provided for @askHint.
  ///
  /// In en, this message translates to:
  /// **'What am I forgetting?'**
  String get askHint;

  /// No description provided for @askNotConnected.
  ///
  /// In en, this message translates to:
  /// **'Asking is not connected yet. Once it is, answers will come only from what you have added, with sources.'**
  String get askNotConnected;

  /// No description provided for @settingsTooltip.
  ///
  /// In en, this message translates to:
  /// **'Settings and privacy'**
  String get settingsTooltip;

  /// No description provided for @greetingMorning.
  ///
  /// In en, this message translates to:
  /// **'Good morning'**
  String get greetingMorning;

  /// No description provided for @greetingAfternoon.
  ///
  /// In en, this message translates to:
  /// **'Good afternoon'**
  String get greetingAfternoon;

  /// No description provided for @greetingEvening.
  ///
  /// In en, this message translates to:
  /// **'Good evening'**
  String get greetingEvening;

  /// No description provided for @todayHappening.
  ///
  /// In en, this message translates to:
  /// **'HAPPENING'**
  String get todayHappening;

  /// No description provided for @todayNothingScheduledTitle.
  ///
  /// In en, this message translates to:
  /// **'Nothing scheduled'**
  String get todayNothingScheduledTitle;

  /// No description provided for @todayNothingScheduledBody.
  ///
  /// In en, this message translates to:
  /// **'Events and tasks due today will appear here.'**
  String get todayNothingScheduledBody;

  /// No description provided for @todayAttention.
  ///
  /// In en, this message translates to:
  /// **'NEEDS ATTENTION'**
  String get todayAttention;

  /// No description provided for @todayAllClearTitle.
  ///
  /// In en, this message translates to:
  /// **'All clear'**
  String get todayAllClearTitle;

  /// No description provided for @todayAllClearBody.
  ///
  /// In en, this message translates to:
  /// **'Expiring documents, upcoming birthdays and open commitments will surface here, each with the reason why.'**
  String get todayAllClearBody;

  /// No description provided for @tasksTabToday.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get tasksTabToday;

  /// No description provided for @tasksTabUpcoming.
  ///
  /// In en, this message translates to:
  /// **'Upcoming'**
  String get tasksTabUpcoming;

  /// No description provided for @tasksTabSomeday.
  ///
  /// In en, this message translates to:
  /// **'Someday'**
  String get tasksTabSomeday;

  /// No description provided for @tasksEmptyTodayTitle.
  ///
  /// In en, this message translates to:
  /// **'Nothing due today'**
  String get tasksEmptyTodayTitle;

  /// No description provided for @tasksEmptyTodayBody.
  ///
  /// In en, this message translates to:
  /// **'Tasks due today and overdue tasks appear here.'**
  String get tasksEmptyTodayBody;

  /// No description provided for @tasksEmptyUpcomingTitle.
  ///
  /// In en, this message translates to:
  /// **'Nothing upcoming'**
  String get tasksEmptyUpcomingTitle;

  /// No description provided for @tasksEmptyUpcomingBody.
  ///
  /// In en, this message translates to:
  /// **'Tasks with a future due date appear here.'**
  String get tasksEmptyUpcomingBody;

  /// No description provided for @tasksEmptySomedayTitle.
  ///
  /// In en, this message translates to:
  /// **'No someday tasks'**
  String get tasksEmptySomedayTitle;

  /// No description provided for @tasksEmptySomedayBody.
  ///
  /// In en, this message translates to:
  /// **'Tasks without a date appear here.'**
  String get tasksEmptySomedayBody;

  /// No description provided for @documentsEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'No documents yet'**
  String get documentsEmptyTitle;

  /// No description provided for @documentsEmptyBody.
  ///
  /// In en, this message translates to:
  /// **'Insurance, warranties, IDs and receipts you add are stored encrypted on this phone. Key dates are extracted for your review before any reminder is created.'**
  String get documentsEmptyBody;

  /// No description provided for @lifeTabTimeline.
  ///
  /// In en, this message translates to:
  /// **'Timeline'**
  String get lifeTabTimeline;

  /// No description provided for @lifeTabPeople.
  ///
  /// In en, this message translates to:
  /// **'People'**
  String get lifeTabPeople;

  /// No description provided for @lifeTabThings.
  ///
  /// In en, this message translates to:
  /// **'Things'**
  String get lifeTabThings;

  /// No description provided for @lifeTimelineEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'Your timeline is empty'**
  String get lifeTimelineEmptyTitle;

  /// No description provided for @lifeTimelineEmptyBody.
  ///
  /// In en, this message translates to:
  /// **'Fills in by itself: upcoming events, tasks, birthdays and expiry dates, and what you added or completed.'**
  String get lifeTimelineEmptyBody;

  /// No description provided for @lifePeopleEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'No people yet'**
  String get lifePeopleEmptyTitle;

  /// No description provided for @lifePeopleEmptyBody.
  ///
  /// In en, this message translates to:
  /// **'Add your family and the people who matter. Birthdays are remembered every year, and everything that mentions them is gathered on their page.'**
  String get lifePeopleEmptyBody;

  /// No description provided for @lifeThingsEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'No things yet'**
  String get lifeThingsEmptyTitle;

  /// No description provided for @lifeThingsEmptyBody.
  ///
  /// In en, this message translates to:
  /// **'Add your car, home, subscriptions and devices with their dates — inspection, insurance, renewal — and get reminded in time.'**
  String get lifeThingsEmptyBody;

  /// No description provided for @memoryEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'LIFE OS knows nothing yet'**
  String get memoryEmptyTitle;

  /// No description provided for @memoryEmptyBody.
  ///
  /// In en, this message translates to:
  /// **'Tell LIFE OS about your life with the + button. Everything it remembers is listed here with where it came from, and you can edit or delete any of it.'**
  String get memoryEmptyBody;

  /// No description provided for @settingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Settings & privacy'**
  String get settingsTitle;

  /// No description provided for @settingsTrust.
  ///
  /// In en, this message translates to:
  /// **'TRUST'**
  String get settingsTrust;

  /// No description provided for @settingsPermissions.
  ///
  /// In en, this message translates to:
  /// **'Permissions'**
  String get settingsPermissions;

  /// No description provided for @settingsPermissionsSub.
  ///
  /// In en, this message translates to:
  /// **'What LIFE OS may read and do'**
  String get settingsPermissionsSub;

  /// No description provided for @settingsActivity.
  ///
  /// In en, this message translates to:
  /// **'Activity'**
  String get settingsActivity;

  /// No description provided for @settingsActivitySub.
  ///
  /// In en, this message translates to:
  /// **'Audit trail of every action'**
  String get settingsActivitySub;

  /// No description provided for @settingsConnection.
  ///
  /// In en, this message translates to:
  /// **'CONNECTION'**
  String get settingsConnection;

  /// No description provided for @settingsRelay.
  ///
  /// In en, this message translates to:
  /// **'AI relay'**
  String get settingsRelay;

  /// No description provided for @settingsRelayNotConfigured.
  ///
  /// In en, this message translates to:
  /// **'Not configured'**
  String get settingsRelayNotConfigured;

  /// No description provided for @settingsSafety.
  ///
  /// In en, this message translates to:
  /// **'SAFETY'**
  String get settingsSafety;

  /// No description provided for @settingsEmergency.
  ///
  /// In en, this message translates to:
  /// **'Emergency card'**
  String get settingsEmergency;

  /// No description provided for @settingsEmergencySub.
  ///
  /// In en, this message translates to:
  /// **'Choose exactly what is shown'**
  String get settingsEmergencySub;

  /// No description provided for @settingsYourData.
  ///
  /// In en, this message translates to:
  /// **'YOUR DATA'**
  String get settingsYourData;

  /// No description provided for @settingsExport.
  ///
  /// In en, this message translates to:
  /// **'Export everything'**
  String get settingsExport;

  /// No description provided for @settingsDelete.
  ///
  /// In en, this message translates to:
  /// **'Delete all data'**
  String get settingsDelete;

  /// No description provided for @settingsPreferences.
  ///
  /// In en, this message translates to:
  /// **'PREFERENCES'**
  String get settingsPreferences;

  /// No description provided for @settingsLanguage.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get settingsLanguage;

  /// No description provided for @languageSystem.
  ///
  /// In en, this message translates to:
  /// **'System default'**
  String get languageSystem;

  /// No description provided for @onboardingTitle.
  ///
  /// In en, this message translates to:
  /// **'Welcome to LIFE OS'**
  String get onboardingTitle;

  /// No description provided for @onboardingPrivate.
  ///
  /// In en, this message translates to:
  /// **'Your data stays on this phone, encrypted.'**
  String get onboardingPrivate;

  /// No description provided for @onboardingAsks.
  ///
  /// In en, this message translates to:
  /// **'It asks before it acts, and shows you what it will do.'**
  String get onboardingAsks;

  /// No description provided for @onboardingSources.
  ///
  /// In en, this message translates to:
  /// **'Answers come only from what you add, with sources.'**
  String get onboardingSources;

  /// No description provided for @onboardingContinue.
  ///
  /// In en, this message translates to:
  /// **'Set up app lock'**
  String get onboardingContinue;

  /// No description provided for @lockReason.
  ///
  /// In en, this message translates to:
  /// **'Unlock LIFE OS'**
  String get lockReason;

  /// No description provided for @lockTitle.
  ///
  /// In en, this message translates to:
  /// **'LIFE OS is locked'**
  String get lockTitle;

  /// No description provided for @lockUnlock.
  ///
  /// In en, this message translates to:
  /// **'Unlock'**
  String get lockUnlock;

  /// No description provided for @lockNoCredential.
  ///
  /// In en, this message translates to:
  /// **'Set a screen lock (PIN, pattern, password or fingerprint) in Android settings to use LIFE OS. It protects your data if the phone is lost.'**
  String get lockNoCredential;

  /// No description provided for @lockLockedOut.
  ///
  /// In en, this message translates to:
  /// **'Too many attempts. Wait a moment, then try again.'**
  String get lockLockedOut;

  /// No description provided for @lockFailed.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t unlock. Try again.'**
  String get lockFailed;

  /// No description provided for @relayExplain.
  ///
  /// In en, this message translates to:
  /// **'LIFE OS reaches the AI through your own relay server, which holds the API key. Your data stays on this phone; only what a question needs is sent.'**
  String get relayExplain;

  /// No description provided for @relayUrl.
  ///
  /// In en, this message translates to:
  /// **'Relay address'**
  String get relayUrl;

  /// No description provided for @relayToken.
  ///
  /// In en, this message translates to:
  /// **'Device token'**
  String get relayToken;

  /// No description provided for @relayTestAndSave.
  ///
  /// In en, this message translates to:
  /// **'Test and save'**
  String get relayTestAndSave;

  /// No description provided for @relayConnected.
  ///
  /// In en, this message translates to:
  /// **'Connected'**
  String get relayConnected;

  /// No description provided for @relayRemove.
  ///
  /// In en, this message translates to:
  /// **'Disconnect'**
  String get relayRemove;

  /// No description provided for @relayErrorHttps.
  ///
  /// In en, this message translates to:
  /// **'The address must start with https://'**
  String get relayErrorHttps;

  /// No description provided for @relayErrorToken.
  ///
  /// In en, this message translates to:
  /// **'The token must be at least 32 characters.'**
  String get relayErrorToken;

  /// No description provided for @relayErrorUnauthorized.
  ///
  /// In en, this message translates to:
  /// **'The relay rejected this token.'**
  String get relayErrorUnauthorized;

  /// No description provided for @relayErrorOffline.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t reach the relay. Check the address and your connection.'**
  String get relayErrorOffline;

  /// No description provided for @relayErrorOther.
  ///
  /// In en, this message translates to:
  /// **'The relay returned an error ({code}).'**
  String relayErrorOther(String code);

  /// No description provided for @relaySaved.
  ///
  /// In en, this message translates to:
  /// **'Relay connected'**
  String get relaySaved;

  /// No description provided for @permissionsExplain.
  ///
  /// In en, this message translates to:
  /// **'Turn off anything you don\'t want LIFE OS to use. Actions set to \"Ask me first\" always show a preview for your approval.'**
  String get permissionsExplain;

  /// No description provided for @permissionsRead.
  ///
  /// In en, this message translates to:
  /// **'WHAT IT CAN SEE'**
  String get permissionsRead;

  /// No description provided for @permissionsAct.
  ///
  /// In en, this message translates to:
  /// **'WHAT IT CAN DO'**
  String get permissionsAct;

  /// No description provided for @permissionAskFirst.
  ///
  /// In en, this message translates to:
  /// **'Ask me first'**
  String get permissionAskFirst;

  /// No description provided for @capReadMemory.
  ///
  /// In en, this message translates to:
  /// **'Your memories'**
  String get capReadMemory;

  /// No description provided for @capReadDocuments.
  ///
  /// In en, this message translates to:
  /// **'Your documents'**
  String get capReadDocuments;

  /// No description provided for @capReadTasks.
  ///
  /// In en, this message translates to:
  /// **'Your tasks'**
  String get capReadTasks;

  /// No description provided for @capReadCalendar.
  ///
  /// In en, this message translates to:
  /// **'Your calendar'**
  String get capReadCalendar;

  /// No description provided for @capCreateTask.
  ///
  /// In en, this message translates to:
  /// **'Create tasks'**
  String get capCreateTask;

  /// No description provided for @capCreateReminder.
  ///
  /// In en, this message translates to:
  /// **'Create reminders'**
  String get capCreateReminder;

  /// No description provided for @capCreateEvent.
  ///
  /// In en, this message translates to:
  /// **'Create events'**
  String get capCreateEvent;

  /// No description provided for @capWriteMemory.
  ///
  /// In en, this message translates to:
  /// **'Remember and correct facts'**
  String get capWriteMemory;

  /// No description provided for @activityEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'No activity yet'**
  String get activityEmptyTitle;

  /// No description provided for @activityEmptyBody.
  ///
  /// In en, this message translates to:
  /// **'Permission changes, unlocks and every action LIFE OS takes are recorded here.'**
  String get activityEmptyBody;

  /// No description provided for @auditAppUnlocked.
  ///
  /// In en, this message translates to:
  /// **'App unlocked'**
  String get auditAppUnlocked;

  /// No description provided for @auditPermissionsSeeded.
  ///
  /// In en, this message translates to:
  /// **'Default permissions set'**
  String get auditPermissionsSeeded;

  /// No description provided for @auditPermissionGranted.
  ///
  /// In en, this message translates to:
  /// **'Permission turned on'**
  String get auditPermissionGranted;

  /// No description provided for @auditPermissionRevoked.
  ///
  /// In en, this message translates to:
  /// **'Permission turned off'**
  String get auditPermissionRevoked;

  /// No description provided for @auditAskFirstOn.
  ///
  /// In en, this message translates to:
  /// **'\"Ask me first\" turned on'**
  String get auditAskFirstOn;

  /// No description provided for @auditAskFirstOff.
  ///
  /// In en, this message translates to:
  /// **'\"Ask me first\" turned off'**
  String get auditAskFirstOff;

  /// No description provided for @auditRelayPaired.
  ///
  /// In en, this message translates to:
  /// **'Relay connected'**
  String get auditRelayPaired;

  /// No description provided for @auditRelayRemoved.
  ///
  /// In en, this message translates to:
  /// **'Relay disconnected'**
  String get auditRelayRemoved;

  /// No description provided for @memoryAdd.
  ///
  /// In en, this message translates to:
  /// **'Add memory'**
  String get memoryAdd;

  /// No description provided for @memoryCaptureHint.
  ///
  /// In en, this message translates to:
  /// **'Tell LIFE OS something about your life'**
  String get memoryCaptureHint;

  /// No description provided for @memoryCaptureExample.
  ///
  /// In en, this message translates to:
  /// **'e.g. My car is a BYD Seal U. I prefer morning flights.'**
  String get memoryCaptureExample;

  /// No description provided for @memoryOrganizeWithAi.
  ///
  /// In en, this message translates to:
  /// **'Organize with AI'**
  String get memoryOrganizeWithAi;

  /// No description provided for @memoryOrganizeNote.
  ///
  /// In en, this message translates to:
  /// **'The text is sent to your AI relay to categorize it.'**
  String get memoryOrganizeNote;

  /// No description provided for @memoryContinue.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get memoryContinue;

  /// No description provided for @memorySave.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get memorySave;

  /// No description provided for @memoryCategory.
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get memoryCategory;

  /// No description provided for @memoryPreviewTitle.
  ///
  /// In en, this message translates to:
  /// **'LIFE OS will remember'**
  String get memoryPreviewTitle;

  /// No description provided for @memoryRetractPreviewTitle.
  ///
  /// In en, this message translates to:
  /// **'Mark as no longer true'**
  String get memoryRetractPreviewTitle;

  /// No description provided for @memoryRetractNoMatch.
  ///
  /// In en, this message translates to:
  /// **'No matching memory was found. You can save this as a new note instead.'**
  String get memoryRetractNoMatch;

  /// No description provided for @memorySaveAsNote.
  ///
  /// In en, this message translates to:
  /// **'Save as note'**
  String get memorySaveAsNote;

  /// No description provided for @memoryReplaces.
  ///
  /// In en, this message translates to:
  /// **'Replaces: {old}'**
  String memoryReplaces(String old);

  /// No description provided for @memoryAiUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t organize it with AI. You can save it as written.'**
  String get memoryAiUnavailable;

  /// No description provided for @memorySpecialCategoryNote.
  ///
  /// In en, this message translates to:
  /// **'Marked as highly sensitive. It stays encrypted on this phone.'**
  String get memorySpecialCategoryNote;

  /// No description provided for @memoryRemembered.
  ///
  /// In en, this message translates to:
  /// **'Remembered'**
  String get memoryRemembered;

  /// No description provided for @memoryUpdatedKeepsHistory.
  ///
  /// In en, this message translates to:
  /// **'Updated. The previous version is kept in history.'**
  String get memoryUpdatedKeepsHistory;

  /// No description provided for @memoryMarkedNotTrue.
  ///
  /// In en, this message translates to:
  /// **'Marked as no longer true'**
  String get memoryMarkedNotTrue;

  /// No description provided for @memoryDeleted.
  ///
  /// In en, this message translates to:
  /// **'Deleted'**
  String get memoryDeleted;

  /// No description provided for @memorySearchHint.
  ///
  /// In en, this message translates to:
  /// **'Search memories'**
  String get memorySearchHint;

  /// No description provided for @memoryNoResults.
  ///
  /// In en, this message translates to:
  /// **'No memories match.'**
  String get memoryNoResults;

  /// No description provided for @memorySourceUser.
  ///
  /// In en, this message translates to:
  /// **'You told LIFE OS'**
  String get memorySourceUser;

  /// No description provided for @memorySourceDocument.
  ///
  /// In en, this message translates to:
  /// **'From a document'**
  String get memorySourceDocument;

  /// No description provided for @memorySourceAi.
  ///
  /// In en, this message translates to:
  /// **'Suggested by AI'**
  String get memorySourceAi;

  /// No description provided for @memorySourceIntegration.
  ///
  /// In en, this message translates to:
  /// **'From a connected app'**
  String get memorySourceIntegration;

  /// No description provided for @memorySourceSystem.
  ///
  /// In en, this message translates to:
  /// **'Added by LIFE OS'**
  String get memorySourceSystem;

  /// No description provided for @memoryValidUntil.
  ///
  /// In en, this message translates to:
  /// **'Valid until {date}'**
  String memoryValidUntil(String date);

  /// No description provided for @memoryEndedOn.
  ///
  /// In en, this message translates to:
  /// **'No longer true since {date}'**
  String memoryEndedOn(String date);

  /// No description provided for @memoryRecordedOn.
  ///
  /// In en, this message translates to:
  /// **'Recorded {date}'**
  String memoryRecordedOn(String date);

  /// No description provided for @memoryHistory.
  ///
  /// In en, this message translates to:
  /// **'HISTORY'**
  String get memoryHistory;

  /// No description provided for @memoryHistoryEmpty.
  ///
  /// In en, this message translates to:
  /// **'No earlier versions.'**
  String get memoryHistoryEmpty;

  /// No description provided for @memoryHistoryEdited.
  ///
  /// In en, this message translates to:
  /// **'Before editing'**
  String get memoryHistoryEdited;

  /// No description provided for @memoryHistoryReplaced.
  ///
  /// In en, this message translates to:
  /// **'Replaced'**
  String get memoryHistoryReplaced;

  /// No description provided for @memoryHistoryRetracted.
  ///
  /// In en, this message translates to:
  /// **'Marked no longer true'**
  String get memoryHistoryRetracted;

  /// No description provided for @memoryEdit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get memoryEdit;

  /// No description provided for @memoryNoLongerTrue.
  ///
  /// In en, this message translates to:
  /// **'No longer true'**
  String get memoryNoLongerTrue;

  /// No description provided for @memoryDelete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get memoryDelete;

  /// No description provided for @memoryDeleteConfirmTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete this memory?'**
  String get memoryDeleteConfirmTitle;

  /// No description provided for @memoryDeleteConfirmBody.
  ///
  /// In en, this message translates to:
  /// **'It will be removed from this phone with its history. This can\'t be undone.'**
  String get memoryDeleteConfirmBody;

  /// No description provided for @memoryCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get memoryCancel;

  /// No description provided for @catFamily.
  ///
  /// In en, this message translates to:
  /// **'Family'**
  String get catFamily;

  /// No description provided for @catVehicle.
  ///
  /// In en, this message translates to:
  /// **'Vehicle'**
  String get catVehicle;

  /// No description provided for @catHome.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get catHome;

  /// No description provided for @catHealth.
  ///
  /// In en, this message translates to:
  /// **'Health'**
  String get catHealth;

  /// No description provided for @catWork.
  ///
  /// In en, this message translates to:
  /// **'Work'**
  String get catWork;

  /// No description provided for @catFinance.
  ///
  /// In en, this message translates to:
  /// **'Finance'**
  String get catFinance;

  /// No description provided for @catTravel.
  ///
  /// In en, this message translates to:
  /// **'Travel'**
  String get catTravel;

  /// No description provided for @catPreference.
  ///
  /// In en, this message translates to:
  /// **'Preferences'**
  String get catPreference;

  /// No description provided for @catRoutine.
  ///
  /// In en, this message translates to:
  /// **'Routines'**
  String get catRoutine;

  /// No description provided for @catOther.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get catOther;

  /// No description provided for @auditMemoryCreated.
  ///
  /// In en, this message translates to:
  /// **'Memory added'**
  String get auditMemoryCreated;

  /// No description provided for @auditMemoryEdited.
  ///
  /// In en, this message translates to:
  /// **'Memory edited'**
  String get auditMemoryEdited;

  /// No description provided for @auditMemoryRetracted.
  ///
  /// In en, this message translates to:
  /// **'Memory marked no longer true'**
  String get auditMemoryRetracted;

  /// No description provided for @auditMemorySuperseded.
  ///
  /// In en, this message translates to:
  /// **'Memory replaced by a newer one'**
  String get auditMemorySuperseded;

  /// No description provided for @auditMemoryDeleted.
  ///
  /// In en, this message translates to:
  /// **'Memory deleted'**
  String get auditMemoryDeleted;

  /// No description provided for @tasksAdd.
  ///
  /// In en, this message translates to:
  /// **'Add task'**
  String get tasksAdd;

  /// No description provided for @quickAddHint.
  ///
  /// In en, this message translates to:
  /// **'What needs doing?'**
  String get quickAddHint;

  /// No description provided for @quickAddExample.
  ///
  /// In en, this message translates to:
  /// **'e.g. Call insurance tomorrow at 9'**
  String get quickAddExample;

  /// No description provided for @quickAddTask.
  ///
  /// In en, this message translates to:
  /// **'Task'**
  String get quickAddTask;

  /// No description provided for @quickAddEvent.
  ///
  /// In en, this message translates to:
  /// **'Event'**
  String get quickAddEvent;

  /// No description provided for @quickAddNoDate.
  ///
  /// In en, this message translates to:
  /// **'No date'**
  String get quickAddNoDate;

  /// No description provided for @quickAddRemind.
  ///
  /// In en, this message translates to:
  /// **'Remind me'**
  String get quickAddRemind;

  /// No description provided for @quickAddEventRemind.
  ///
  /// In en, this message translates to:
  /// **'Remind me 15 minutes before'**
  String get quickAddEventRemind;

  /// No description provided for @quickAddEventNeedsTime.
  ///
  /// In en, this message translates to:
  /// **'An event needs a start time.'**
  String get quickAddEventNeedsTime;

  /// No description provided for @quickAddSave.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get quickAddSave;

  /// No description provided for @quickAddClearDate.
  ///
  /// In en, this message translates to:
  /// **'Remove date'**
  String get quickAddClearDate;

  /// No description provided for @quickAddAllDay.
  ///
  /// In en, this message translates to:
  /// **'All day'**
  String get quickAddAllDay;

  /// No description provided for @repeatNone.
  ///
  /// In en, this message translates to:
  /// **'Doesn\'t repeat'**
  String get repeatNone;

  /// No description provided for @repeatDaily.
  ///
  /// In en, this message translates to:
  /// **'Every day'**
  String get repeatDaily;

  /// No description provided for @repeatWeekly.
  ///
  /// In en, this message translates to:
  /// **'Every week'**
  String get repeatWeekly;

  /// No description provided for @repeatMonthly.
  ///
  /// In en, this message translates to:
  /// **'Every month'**
  String get repeatMonthly;

  /// No description provided for @repeatYearly.
  ///
  /// In en, this message translates to:
  /// **'Every year'**
  String get repeatYearly;

  /// No description provided for @repeatEveryNDays.
  ///
  /// In en, this message translates to:
  /// **'Every {n} days'**
  String repeatEveryNDays(int n);

  /// No description provided for @taskDone.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get taskDone;

  /// No description provided for @taskNextOccurrence.
  ///
  /// In en, this message translates to:
  /// **'Done. Next: {date}'**
  String taskNextOccurrence(String date);

  /// No description provided for @taskUndo.
  ///
  /// In en, this message translates to:
  /// **'Undo'**
  String get taskUndo;

  /// No description provided for @taskSave.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get taskSave;

  /// No description provided for @taskDelete.
  ///
  /// In en, this message translates to:
  /// **'Delete task'**
  String get taskDelete;

  /// No description provided for @taskDeleted.
  ///
  /// In en, this message translates to:
  /// **'Task deleted'**
  String get taskDeleted;

  /// No description provided for @taskNotes.
  ///
  /// In en, this message translates to:
  /// **'Notes'**
  String get taskNotes;

  /// No description provided for @dueToday.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get dueToday;

  /// No description provided for @dueTomorrow.
  ///
  /// In en, this message translates to:
  /// **'Tomorrow'**
  String get dueTomorrow;

  /// No description provided for @dueYesterday.
  ///
  /// In en, this message translates to:
  /// **'Yesterday'**
  String get dueYesterday;

  /// No description provided for @tasksOverdueHeader.
  ///
  /// In en, this message translates to:
  /// **'OVERDUE'**
  String get tasksOverdueHeader;

  /// No description provided for @tasksTodayHeader.
  ///
  /// In en, this message translates to:
  /// **'TODAY'**
  String get tasksTodayHeader;

  /// No description provided for @todayOverdue.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 overdue task} other{{count} overdue tasks}}'**
  String todayOverdue(int count);

  /// No description provided for @reminderChannel.
  ///
  /// In en, this message translates to:
  /// **'Reminders'**
  String get reminderChannel;

  /// No description provided for @auditTaskCreated.
  ///
  /// In en, this message translates to:
  /// **'Task added'**
  String get auditTaskCreated;

  /// No description provided for @auditTaskCompleted.
  ///
  /// In en, this message translates to:
  /// **'Task completed'**
  String get auditTaskCompleted;

  /// No description provided for @auditTaskReopened.
  ///
  /// In en, this message translates to:
  /// **'Task reopened'**
  String get auditTaskReopened;

  /// No description provided for @auditTaskEdited.
  ///
  /// In en, this message translates to:
  /// **'Task edited'**
  String get auditTaskEdited;

  /// No description provided for @auditTaskDeleted.
  ///
  /// In en, this message translates to:
  /// **'Task deleted'**
  String get auditTaskDeleted;

  /// No description provided for @auditEventCreated.
  ///
  /// In en, this message translates to:
  /// **'Event added'**
  String get auditEventCreated;

  /// No description provided for @auditEventDeleted.
  ///
  /// In en, this message translates to:
  /// **'Event deleted'**
  String get auditEventDeleted;

  /// No description provided for @auditReminderCreated.
  ///
  /// In en, this message translates to:
  /// **'Reminder added'**
  String get auditReminderCreated;

  /// No description provided for @quickAddRepeatTooltip.
  ///
  /// In en, this message translates to:
  /// **'Repeat'**
  String get quickAddRepeatTooltip;

  /// No description provided for @docAdd.
  ///
  /// In en, this message translates to:
  /// **'Add document'**
  String get docAdd;

  /// No description provided for @docChooseFile.
  ///
  /// In en, this message translates to:
  /// **'Choose a file'**
  String get docChooseFile;

  /// No description provided for @docTakePhoto.
  ///
  /// In en, this message translates to:
  /// **'Take a photo'**
  String get docTakePhoto;

  /// No description provided for @docReading.
  ///
  /// In en, this message translates to:
  /// **'Reading the document on this phone…'**
  String get docReading;

  /// No description provided for @docAlreadyAdded.
  ///
  /// In en, this message translates to:
  /// **'This document was already added.'**
  String get docAlreadyAdded;

  /// No description provided for @docUnsupported.
  ///
  /// In en, this message translates to:
  /// **'Only PDF, JPG and PNG files up to 25 MB.'**
  String get docUnsupported;

  /// No description provided for @docReviewTitle.
  ///
  /// In en, this message translates to:
  /// **'Review'**
  String get docReviewTitle;

  /// No description provided for @docReviewIntro.
  ///
  /// In en, this message translates to:
  /// **'Check what LIFE OS read. Only the items you keep are saved.'**
  String get docReviewIntro;

  /// No description provided for @docType.
  ///
  /// In en, this message translates to:
  /// **'Type'**
  String get docType;

  /// No description provided for @docFindWithAi.
  ///
  /// In en, this message translates to:
  /// **'Find more with AI'**
  String get docFindWithAi;

  /// No description provided for @docAiNote.
  ///
  /// In en, this message translates to:
  /// **'Sends the document\'s text (not the file) to your AI relay. Every suggestion must quote the document.'**
  String get docAiNote;

  /// No description provided for @docLocalOnlyNote.
  ///
  /// In en, this message translates to:
  /// **'ID and health documents are read on this phone only.'**
  String get docLocalOnlyNote;

  /// No description provided for @docAiFound.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{The AI found nothing new.} =1{1 more item found} other{{count} more items found}}'**
  String docAiFound(int count);

  /// No description provided for @docAiFailed.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t reach the AI.'**
  String get docAiFailed;

  /// No description provided for @docSourceLocal.
  ///
  /// In en, this message translates to:
  /// **'Read on this phone'**
  String get docSourceLocal;

  /// No description provided for @docNoFields.
  ///
  /// In en, this message translates to:
  /// **'No dates or numbers were found. You can still keep the document.'**
  String get docNoFields;

  /// No description provided for @docOcrFailed.
  ///
  /// In en, this message translates to:
  /// **'The text couldn\'t be read. You can still keep the file.'**
  String get docOcrFailed;

  /// No description provided for @docRemindBefore.
  ///
  /// In en, this message translates to:
  /// **'Remind me {days} days before'**
  String docRemindBefore(int days);

  /// No description provided for @docSaved.
  ///
  /// In en, this message translates to:
  /// **'Saved'**
  String get docSaved;

  /// No description provided for @docSavedWithReminder.
  ///
  /// In en, this message translates to:
  /// **'Saved. Reminder on {date}.'**
  String docSavedWithReminder(String date);

  /// No description provided for @docReminderTitle.
  ///
  /// In en, this message translates to:
  /// **'{title} — expires {date}'**
  String docReminderTitle(String title, String date);

  /// No description provided for @docNeedsReview.
  ///
  /// In en, this message translates to:
  /// **'Needs review'**
  String get docNeedsReview;

  /// No description provided for @docExpires.
  ///
  /// In en, this message translates to:
  /// **'Expires {date}'**
  String docExpires(String date);

  /// No description provided for @docFields.
  ///
  /// In en, this message translates to:
  /// **'DETAILS'**
  String get docFields;

  /// No description provided for @docText.
  ///
  /// In en, this message translates to:
  /// **'TEXT'**
  String get docText;

  /// No description provided for @docDelete.
  ///
  /// In en, this message translates to:
  /// **'Delete document'**
  String get docDelete;

  /// No description provided for @docDeleteConfirmTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete this document?'**
  String get docDeleteConfirmTitle;

  /// No description provided for @docDeleteConfirmBody.
  ///
  /// In en, this message translates to:
  /// **'The file, its details and its reminders will be removed from this phone.'**
  String get docDeleteConfirmBody;

  /// No description provided for @docDeleted.
  ///
  /// In en, this message translates to:
  /// **'Document deleted'**
  String get docDeleted;

  /// No description provided for @docEditValue.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get docEditValue;

  /// No description provided for @fieldExpiresOn.
  ///
  /// In en, this message translates to:
  /// **'Expires'**
  String get fieldExpiresOn;

  /// No description provided for @fieldStartsOn.
  ///
  /// In en, this message translates to:
  /// **'Starts'**
  String get fieldStartsOn;

  /// No description provided for @fieldDueOn.
  ///
  /// In en, this message translates to:
  /// **'Payment due'**
  String get fieldDueOn;

  /// No description provided for @fieldIssuedOn.
  ///
  /// In en, this message translates to:
  /// **'Issued'**
  String get fieldIssuedOn;

  /// No description provided for @fieldRenewsOn.
  ///
  /// In en, this message translates to:
  /// **'Renewal'**
  String get fieldRenewsOn;

  /// No description provided for @fieldPolicyNumber.
  ///
  /// In en, this message translates to:
  /// **'Policy number'**
  String get fieldPolicyNumber;

  /// No description provided for @fieldProvider.
  ///
  /// In en, this message translates to:
  /// **'Provider'**
  String get fieldProvider;

  /// No description provided for @fieldVehiclePlate.
  ///
  /// In en, this message translates to:
  /// **'Plate'**
  String get fieldVehiclePlate;

  /// No description provided for @fieldVehicleModel.
  ///
  /// In en, this message translates to:
  /// **'Vehicle'**
  String get fieldVehicleModel;

  /// No description provided for @fieldAmount.
  ///
  /// In en, this message translates to:
  /// **'Amount'**
  String get fieldAmount;

  /// No description provided for @fieldReference.
  ///
  /// In en, this message translates to:
  /// **'Reference'**
  String get fieldReference;

  /// No description provided for @docTypeInsurance.
  ///
  /// In en, this message translates to:
  /// **'Insurance'**
  String get docTypeInsurance;

  /// No description provided for @docTypeVehicleRegistration.
  ///
  /// In en, this message translates to:
  /// **'Vehicle registration'**
  String get docTypeVehicleRegistration;

  /// No description provided for @docTypePassport.
  ///
  /// In en, this message translates to:
  /// **'Passport'**
  String get docTypePassport;

  /// No description provided for @docTypeIdCard.
  ///
  /// In en, this message translates to:
  /// **'ID card'**
  String get docTypeIdCard;

  /// No description provided for @docTypeDriverLicense.
  ///
  /// In en, this message translates to:
  /// **'Driving licence'**
  String get docTypeDriverLicense;

  /// No description provided for @docTypeWarranty.
  ///
  /// In en, this message translates to:
  /// **'Warranty'**
  String get docTypeWarranty;

  /// No description provided for @docTypeInvoice.
  ///
  /// In en, this message translates to:
  /// **'Invoice'**
  String get docTypeInvoice;

  /// No description provided for @docTypeReceipt.
  ///
  /// In en, this message translates to:
  /// **'Receipt'**
  String get docTypeReceipt;

  /// No description provided for @docTypeContract.
  ///
  /// In en, this message translates to:
  /// **'Contract'**
  String get docTypeContract;

  /// No description provided for @docTypeTravel.
  ///
  /// In en, this message translates to:
  /// **'Travel'**
  String get docTypeTravel;

  /// No description provided for @docTypeMedical.
  ///
  /// In en, this message translates to:
  /// **'Medical'**
  String get docTypeMedical;

  /// No description provided for @docTypeOther.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get docTypeOther;

  /// No description provided for @auditDocumentAdded.
  ///
  /// In en, this message translates to:
  /// **'Document added'**
  String get auditDocumentAdded;

  /// No description provided for @auditDocumentReviewed.
  ///
  /// In en, this message translates to:
  /// **'Document reviewed'**
  String get auditDocumentReviewed;

  /// No description provided for @auditDocumentDeleted.
  ///
  /// In en, this message translates to:
  /// **'Document deleted'**
  String get auditDocumentDeleted;

  /// No description provided for @auditDocumentAiFields.
  ///
  /// In en, this message translates to:
  /// **'AI suggestions checked'**
  String get auditDocumentAiFields;

  /// No description provided for @lifeAddTooltip.
  ///
  /// In en, this message translates to:
  /// **'Add to Life'**
  String get lifeAddTooltip;

  /// No description provided for @lifeAddPerson.
  ///
  /// In en, this message translates to:
  /// **'Add person'**
  String get lifeAddPerson;

  /// No description provided for @lifeAddThing.
  ///
  /// In en, this message translates to:
  /// **'Add thing'**
  String get lifeAddThing;

  /// No description provided for @lifeName.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get lifeName;

  /// No description provided for @lifeRelation.
  ///
  /// In en, this message translates to:
  /// **'Relation'**
  String get lifeRelation;

  /// No description provided for @relSpouse.
  ///
  /// In en, this message translates to:
  /// **'Spouse'**
  String get relSpouse;

  /// No description provided for @relChild.
  ///
  /// In en, this message translates to:
  /// **'Child'**
  String get relChild;

  /// No description provided for @relParent.
  ///
  /// In en, this message translates to:
  /// **'Parent'**
  String get relParent;

  /// No description provided for @relSibling.
  ///
  /// In en, this message translates to:
  /// **'Sibling'**
  String get relSibling;

  /// No description provided for @relRelative.
  ///
  /// In en, this message translates to:
  /// **'Relative'**
  String get relRelative;

  /// No description provided for @relFriend.
  ///
  /// In en, this message translates to:
  /// **'Friend'**
  String get relFriend;

  /// No description provided for @relColleague.
  ///
  /// In en, this message translates to:
  /// **'Colleague'**
  String get relColleague;

  /// No description provided for @relOther.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get relOther;

  /// No description provided for @lifeBirthday.
  ///
  /// In en, this message translates to:
  /// **'Birthday'**
  String get lifeBirthday;

  /// No description provided for @lifeSetBirthday.
  ///
  /// In en, this message translates to:
  /// **'Add birthday'**
  String get lifeSetBirthday;

  /// No description provided for @lifeBirthYearUnknown.
  ///
  /// In en, this message translates to:
  /// **'I don\'t know the year'**
  String get lifeBirthYearUnknown;

  /// No description provided for @lifeNoReminder.
  ///
  /// In en, this message translates to:
  /// **'No reminder'**
  String get lifeNoReminder;

  /// No description provided for @thingVehicle.
  ///
  /// In en, this message translates to:
  /// **'Vehicle'**
  String get thingVehicle;

  /// No description provided for @thingHome.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get thingHome;

  /// No description provided for @thingSubscription.
  ///
  /// In en, this message translates to:
  /// **'Subscription'**
  String get thingSubscription;

  /// No description provided for @thingDevice.
  ///
  /// In en, this message translates to:
  /// **'Device'**
  String get thingDevice;

  /// No description provided for @thingPet.
  ///
  /// In en, this message translates to:
  /// **'Pet'**
  String get thingPet;

  /// No description provided for @thingOther.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get thingOther;

  /// No description provided for @dateKindBirthday.
  ///
  /// In en, this message translates to:
  /// **'Birthday'**
  String get dateKindBirthday;

  /// No description provided for @dateKindExpires.
  ///
  /// In en, this message translates to:
  /// **'Expires'**
  String get dateKindExpires;

  /// No description provided for @dateKindRenews.
  ///
  /// In en, this message translates to:
  /// **'Renewal'**
  String get dateKindRenews;

  /// No description provided for @dateKindInspection.
  ///
  /// In en, this message translates to:
  /// **'Inspection'**
  String get dateKindInspection;

  /// No description provided for @dateKindService.
  ///
  /// In en, this message translates to:
  /// **'Service'**
  String get dateKindService;

  /// No description provided for @dateKindPayment.
  ///
  /// In en, this message translates to:
  /// **'Payment'**
  String get dateKindPayment;

  /// No description provided for @dateKindOther.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get dateKindOther;

  /// No description provided for @dateKindStarts.
  ///
  /// In en, this message translates to:
  /// **'Starts'**
  String get dateKindStarts;

  /// No description provided for @dateKindIssued.
  ///
  /// In en, this message translates to:
  /// **'Issued'**
  String get dateKindIssued;

  /// No description provided for @dateKindDue.
  ///
  /// In en, this message translates to:
  /// **'Due'**
  String get dateKindDue;

  /// No description provided for @lifeAddDate.
  ///
  /// In en, this message translates to:
  /// **'Add date'**
  String get lifeAddDate;

  /// No description provided for @lifeDateKind.
  ///
  /// In en, this message translates to:
  /// **'What date is it?'**
  String get lifeDateKind;

  /// No description provided for @lifePickDate.
  ///
  /// In en, this message translates to:
  /// **'Pick a date'**
  String get lifePickDate;

  /// No description provided for @lifeDates.
  ///
  /// In en, this message translates to:
  /// **'DATES'**
  String get lifeDates;

  /// No description provided for @lifeRelated.
  ///
  /// In en, this message translates to:
  /// **'RELATED'**
  String get lifeRelated;

  /// No description provided for @lifeRelatedNone.
  ///
  /// In en, this message translates to:
  /// **'Nothing mentions {name} yet.'**
  String lifeRelatedNone(String name);

  /// No description provided for @lifeTurns.
  ///
  /// In en, this message translates to:
  /// **'Turns {age} on {date}'**
  String lifeTurns(int age, String date);

  /// No description provided for @lifeNext.
  ///
  /// In en, this message translates to:
  /// **'Next: {date}'**
  String lifeNext(String date);

  /// No description provided for @lifeDeleteConfirmTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete {name}?'**
  String lifeDeleteConfirmTitle(String name);

  /// No description provided for @lifeDelete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get lifeDelete;

  /// No description provided for @lifeDeleted.
  ///
  /// In en, this message translates to:
  /// **'Deleted'**
  String get lifeDeleted;

  /// No description provided for @lifeRemoveDate.
  ///
  /// In en, this message translates to:
  /// **'Remove date'**
  String get lifeRemoveDate;

  /// No description provided for @lifeDeleteConfirmBody.
  ///
  /// In en, this message translates to:
  /// **'Its dates and reminders will be removed too.'**
  String get lifeDeleteConfirmBody;

  /// No description provided for @lifeReminderTitle.
  ///
  /// In en, this message translates to:
  /// **'{name} · {kind} ({date})'**
  String lifeReminderTitle(String name, String kind, String date);

  /// No description provided for @tlEvent.
  ///
  /// In en, this message translates to:
  /// **'Event'**
  String get tlEvent;

  /// No description provided for @tlTaskDue.
  ///
  /// In en, this message translates to:
  /// **'Task'**
  String get tlTaskDue;

  /// No description provided for @tlTaskDone.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get tlTaskDone;

  /// No description provided for @tlDocument.
  ///
  /// In en, this message translates to:
  /// **'Document added'**
  String get tlDocument;

  /// No description provided for @tlMemory.
  ///
  /// In en, this message translates to:
  /// **'Remembered'**
  String get tlMemory;

  /// No description provided for @auditPersonAdded.
  ///
  /// In en, this message translates to:
  /// **'Person added'**
  String get auditPersonAdded;

  /// No description provided for @auditPersonEdited.
  ///
  /// In en, this message translates to:
  /// **'Person edited'**
  String get auditPersonEdited;

  /// No description provided for @auditPersonDeleted.
  ///
  /// In en, this message translates to:
  /// **'Person deleted'**
  String get auditPersonDeleted;

  /// No description provided for @auditThingAdded.
  ///
  /// In en, this message translates to:
  /// **'Thing added'**
  String get auditThingAdded;

  /// No description provided for @auditThingEdited.
  ///
  /// In en, this message translates to:
  /// **'Thing edited'**
  String get auditThingEdited;

  /// No description provided for @auditThingDeleted.
  ///
  /// In en, this message translates to:
  /// **'Thing deleted'**
  String get auditThingDeleted;

  /// No description provided for @auditDateAdded.
  ///
  /// In en, this message translates to:
  /// **'Date added'**
  String get auditDateAdded;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'tr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'tr':
      return AppLocalizationsTr();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
