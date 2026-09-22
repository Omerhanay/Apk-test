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
  /// **'Events, uploads and reminders appear here in order.'**
  String get lifeTimelineEmptyBody;

  /// No description provided for @lifePeopleEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'No people yet'**
  String get lifePeopleEmptyTitle;

  /// No description provided for @lifePeopleEmptyBody.
  ///
  /// In en, this message translates to:
  /// **'People you mention, like family members, are linked here.'**
  String get lifePeopleEmptyBody;

  /// No description provided for @lifeThingsEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'No things yet'**
  String get lifeThingsEmptyTitle;

  /// No description provided for @lifeThingsEmptyBody.
  ///
  /// In en, this message translates to:
  /// **'Vehicles, subscriptions and trips are linked here.'**
  String get lifeThingsEmptyBody;

  /// No description provided for @memoryEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'LIFE OS knows nothing yet'**
  String get memoryEmptyTitle;

  /// No description provided for @memoryEmptyBody.
  ///
  /// In en, this message translates to:
  /// **'Everything LIFE OS remembers will be listed here, with where it came from. You can edit or delete any of it.'**
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
