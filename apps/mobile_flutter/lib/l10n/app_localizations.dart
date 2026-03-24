import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_fr.dart';

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

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
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
    Locale('fr'),
  ];

  /// No description provided for @appName.
  ///
  /// In en, this message translates to:
  /// **'PrimeCare Hub'**
  String get appName;

  /// No description provided for @ok.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get ok;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @success.
  ///
  /// In en, this message translates to:
  /// **'Success'**
  String get success;

  /// No description provided for @error.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get error;

  /// No description provided for @welcomeBack.
  ///
  /// In en, this message translates to:
  /// **'Welcome Back, First Responder!'**
  String get welcomeBack;

  /// No description provided for @nextShiftAnnouncement.
  ///
  /// In en, this message translates to:
  /// **'Your next shift begins in 2h 15m. You have 2 unread announcements.'**
  String get nextShiftAnnouncement;

  /// No description provided for @performanceMetrics.
  ///
  /// In en, this message translates to:
  /// **'Performance Metrics'**
  String get performanceMetrics;

  /// No description provided for @weeklyHoursLabel.
  ///
  /// In en, this message translates to:
  /// **'Weekly Hours'**
  String get weeklyHoursLabel;

  /// No description provided for @complianceLabel.
  ///
  /// In en, this message translates to:
  /// **'Compliance'**
  String get complianceLabel;

  /// No description provided for @surgeActiveLabel.
  ///
  /// In en, this message translates to:
  /// **'Surge Active'**
  String get surgeActiveLabel;

  /// No description provided for @quickAccessNodes.
  ///
  /// In en, this message translates to:
  /// **'Quick Access Nodes'**
  String get quickAccessNodes;

  /// No description provided for @secureInbox.
  ///
  /// In en, this message translates to:
  /// **'Secure Inbox'**
  String get secureInbox;

  /// No description provided for @dailyTimeline.
  ///
  /// In en, this message translates to:
  /// **'Daily Timeline'**
  String get dailyTimeline;

  /// No description provided for @trainingHub.
  ///
  /// In en, this message translates to:
  /// **'Training Hub'**
  String get trainingHub;

  /// No description provided for @sosTrigger.
  ///
  /// In en, this message translates to:
  /// **'SOS Trigger'**
  String get sosTrigger;

  /// No description provided for @viewClients.
  ///
  /// In en, this message translates to:
  /// **'View Clients'**
  String get viewClients;

  /// No description provided for @organizationalFeed.
  ///
  /// In en, this message translates to:
  /// **'Organizational Feed'**
  String get organizationalFeed;

  /// No description provided for @myShiftsTitle.
  ///
  /// In en, this message translates to:
  /// **'My Shifts'**
  String get myShiftsTitle;

  /// No description provided for @highDemandAlertTitle.
  ///
  /// In en, this message translates to:
  /// **'High Demand Alert'**
  String get highDemandAlertTitle;

  /// No description provided for @highDemandAlertDesc.
  ///
  /// In en, this message translates to:
  /// **'Surge pricing active for evening shifts (+1.5x payout rate).'**
  String get highDemandAlertDesc;

  /// No description provided for @today.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get today;

  /// No description provided for @shiftCountLabel.
  ///
  /// In en, this message translates to:
  /// **'3 Shifts'**
  String get shiftCountLabel;

  /// No description provided for @shiftAckSuccess.
  ///
  /// In en, this message translates to:
  /// **'Shift acknowledged successfully.'**
  String get shiftAckSuccess;

  /// No description provided for @undo.
  ///
  /// In en, this message translates to:
  /// **'UNDO'**
  String get undo;

  /// No description provided for @themeConfiguration.
  ///
  /// In en, this message translates to:
  /// **'Theme Configuration'**
  String get themeConfiguration;

  /// No description provided for @selectThemeDesc.
  ///
  /// In en, this message translates to:
  /// **'Select your preferred visual layout. Changes are applied globally.'**
  String get selectThemeDesc;

  /// No description provided for @lightThemeLabel.
  ///
  /// In en, this message translates to:
  /// **'Light (Enterprise Slate)'**
  String get lightThemeLabel;

  /// No description provided for @darkThemeLabel.
  ///
  /// In en, this message translates to:
  /// **'Dark (Obsidian)'**
  String get darkThemeLabel;

  /// No description provided for @highContrastLabel.
  ///
  /// In en, this message translates to:
  /// **'High Contrast (Medical)'**
  String get highContrastLabel;

  /// No description provided for @emailAddress.
  ///
  /// In en, this message translates to:
  /// **'Email Address'**
  String get emailAddress;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @homeDashboard.
  ///
  /// In en, this message translates to:
  /// **'Central Operations Matrix'**
  String get homeDashboard;

  /// No description provided for @wellnessPulse.
  ///
  /// In en, this message translates to:
  /// **'Wellness Pulse'**
  String get wellnessPulse;

  /// No description provided for @autoMaxRoutingComplete28Pending.
  ///
  /// In en, this message translates to:
  /// **'Auto-Max Routing Complete. 28 pending hours assigned continuously.'**
  String get autoMaxRoutingComplete28Pending;

  /// No description provided for @autoMaxFill.
  ///
  /// In en, this message translates to:
  /// **'AUTO-MAX FILL'**
  String get autoMaxFill;

  /// No description provided for @doubleBookingDetectedThePhysicalSchedule.
  ///
  /// In en, this message translates to:
  /// **'DOUBLE-BOOKING DETECTED. The physical schedule matrix rejected the collision constraint.'**
  String get doubleBookingDetectedThePhysicalSchedule;

  /// No description provided for @ping.
  ///
  /// In en, this message translates to:
  /// **'PING'**
  String get ping;

  /// No description provided for @dispatch.
  ///
  /// In en, this message translates to:
  /// **'Dispatch'**
  String get dispatch;

  /// No description provided for @staff.
  ///
  /// In en, this message translates to:
  /// **'Staff'**
  String get staff;

  /// No description provided for @approvals.
  ///
  /// In en, this message translates to:
  /// **'Approvals'**
  String get approvals;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @terminateSession.
  ///
  /// In en, this message translates to:
  /// **'Terminate Session'**
  String get terminateSession;

  /// No description provided for @liveKeywordSearch.
  ///
  /// In en, this message translates to:
  /// **'Live Keyword Search...'**
  String get liveKeywordSearch;

  /// No description provided for @franchiseExpansion.
  ///
  /// In en, this message translates to:
  /// **'FRANCHISE EXPANSION'**
  String get franchiseExpansion;

  /// No description provided for @howToStartANewLocation.
  ///
  /// In en, this message translates to:
  /// **'HOW TO START A NEW LOCATION'**
  String get howToStartANewLocation;

  /// No description provided for @identifyUnderservedZipCodes.
  ///
  /// In en, this message translates to:
  /// **'Identify Underserved Zip Codes'**
  String get identifyUnderservedZipCodes;

  /// No description provided for @incorporateGhostNode.
  ///
  /// In en, this message translates to:
  /// **'Incorporate Ghost Node'**
  String get incorporateGhostNode;

  /// No description provided for @aggressivePswRecruiting.
  ///
  /// In en, this message translates to:
  /// **'Aggressive PSW Recruiting'**
  String get aggressivePswRecruiting;

  /// No description provided for @b2bReferralInitialization.
  ///
  /// In en, this message translates to:
  /// **'B2B Referral Initialization'**
  String get b2bReferralInitialization;

  /// No description provided for @launchGeofencedAdCampaign.
  ///
  /// In en, this message translates to:
  /// **'Launch Geofenced Ad Campaign'**
  String get launchGeofencedAdCampaign;

  /// No description provided for @hub.
  ///
  /// In en, this message translates to:
  /// **'Hub'**
  String get hub;

  /// No description provided for @marketing.
  ///
  /// In en, this message translates to:
  /// **'Marketing'**
  String get marketing;

  /// No description provided for @revenue.
  ///
  /// In en, this message translates to:
  /// **'Revenue'**
  String get revenue;

  /// No description provided for @expand.
  ///
  /// In en, this message translates to:
  /// **'Expand'**
  String get expand;

  /// No description provided for @compliance.
  ///
  /// In en, this message translates to:
  /// **'Compliance'**
  String get compliance;

  /// No description provided for @activeStaff.
  ///
  /// In en, this message translates to:
  /// **'Active Staff'**
  String get activeStaff;

  /// No description provided for @criticalSos.
  ///
  /// In en, this message translates to:
  /// **'Critical SOS'**
  String get criticalSos;

  /// No description provided for @overview.
  ///
  /// In en, this message translates to:
  /// **'Overview'**
  String get overview;

  /// No description provided for @directory.
  ///
  /// In en, this message translates to:
  /// **'Directory'**
  String get directory;

  /// No description provided for @system.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get system;

  /// No description provided for @execute.
  ///
  /// In en, this message translates to:
  /// **'Execute'**
  String get execute;

  /// No description provided for @schedule.
  ///
  /// In en, this message translates to:
  /// **'Schedule'**
  String get schedule;

  /// No description provided for @clients.
  ///
  /// In en, this message translates to:
  /// **'Clients'**
  String get clients;

  /// No description provided for @messages.
  ///
  /// In en, this message translates to:
  /// **'Messages'**
  String get messages;

  /// No description provided for @shiftAcceptedAddedToDashboard.
  ///
  /// In en, this message translates to:
  /// **'Shift Accepted. Localized telemetry synced.'**
  String get shiftAcceptedAddedToDashboard;

  /// No description provided for @typeYourMessage.
  ///
  /// In en, this message translates to:
  /// **'Type your message...'**
  String get typeYourMessage;

  /// No description provided for @viewOfficialDirectivePdf.
  ///
  /// In en, this message translates to:
  /// **'View Official Directive (PDF)'**
  String get viewOfficialDirectivePdf;

  /// No description provided for @activeCarePlanVault.
  ///
  /// In en, this message translates to:
  /// **'Active Care Plan Vault'**
  String get activeCarePlanVault;

  /// No description provided for @txt30DayVitalsTrend.
  ///
  /// In en, this message translates to:
  /// **'30-Day Vitals Trend'**
  String get txt30DayVitalsTrend;

  /// No description provided for @emergencyContacts.
  ///
  /// In en, this message translates to:
  /// **'Emergency Contacts'**
  String get emergencyContacts;

  /// No description provided for @progressNoteAppendedSecurely.
  ///
  /// In en, this message translates to:
  /// **'Progress Note Appended Securely'**
  String get progressNoteAppendedSecurely;

  /// No description provided for @clinicalProgressNote.
  ///
  /// In en, this message translates to:
  /// **'Clinical Progress Note'**
  String get clinicalProgressNote;

  /// No description provided for @describePatientMoodPhysicalChangesOr.
  ///
  /// In en, this message translates to:
  /// **'Describe patient mood, physical changes, or any incidents occurring during this active shift...'**
  String get describePatientMoodPhysicalChangesOr;

  /// No description provided for @maxOptionEnabledDispatchWillAuto.
  ///
  /// In en, this message translates to:
  /// **'Max Option Enabled. Dispatch will auto-assign up to 12 hours.'**
  String get maxOptionEnabledDispatchWillAuto;

  /// No description provided for @shiftCheckoutProtocol.
  ///
  /// In en, this message translates to:
  /// **'Shift Checkout Protocol'**
  String get shiftCheckoutProtocol;

  /// No description provided for @emergencyIncidentWizard.
  ///
  /// In en, this message translates to:
  /// **'Emergency Incident Wizard'**
  String get emergencyIncidentWizard;

  /// No description provided for @evidenceCapture.
  ///
  /// In en, this message translates to:
  /// **'EVIDENCE CAPTURE'**
  String get evidenceCapture;

  /// No description provided for @avatarStagedForUpload.
  ///
  /// In en, this message translates to:
  /// **'Avatar staged for upload!'**
  String get avatarStagedForUpload;

  /// No description provided for @profileSynchronizedWithPrimecareNetworksSafely.
  ///
  /// In en, this message translates to:
  /// **'Profile synchronized with PrimeCare networks safely.'**
  String get profileSynchronizedWithPrimecareNetworksSafely;

  /// No description provided for @changePassword.
  ///
  /// In en, this message translates to:
  /// **'Change Password'**
  String get changePassword;

  /// No description provided for @passwordProtectedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Password protected successfully.'**
  String get passwordProtectedSuccessfully;

  /// No description provided for @update.
  ///
  /// In en, this message translates to:
  /// **'Update'**
  String get update;

  /// No description provided for @currentPassword.
  ///
  /// In en, this message translates to:
  /// **'Current Password'**
  String get currentPassword;

  /// No description provided for @newPassword.
  ///
  /// In en, this message translates to:
  /// **'New Password'**
  String get newPassword;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @shifts.
  ///
  /// In en, this message translates to:
  /// **'Shifts'**
  String get shifts;

  /// No description provided for @timesheet.
  ///
  /// In en, this message translates to:
  /// **'Timesheet'**
  String get timesheet;

  /// No description provided for @scheduleTasks.
  ///
  /// In en, this message translates to:
  /// **'Schedule Tasks'**
  String get scheduleTasks;

  /// No description provided for @complianceModule.
  ///
  /// In en, this message translates to:
  /// **'Compliance Module'**
  String get complianceModule;

  /// No description provided for @triage.
  ///
  /// In en, this message translates to:
  /// **'Triage'**
  String get triage;

  /// No description provided for @patients.
  ///
  /// In en, this message translates to:
  /// **'Patients'**
  String get patients;

  /// No description provided for @inbox.
  ///
  /// In en, this message translates to:
  /// **'Inbox'**
  String get inbox;

  /// No description provided for @criticalRecoveryCompleteAllStateHashes.
  ///
  /// In en, this message translates to:
  /// **'CRITICAL RECOVERY COMPLETE. All state hashes structurally reset to Genesis block.'**
  String get criticalRecoveryCompleteAllStateHashes;

  /// No description provided for @systemHub.
  ///
  /// In en, this message translates to:
  /// **'System Hub'**
  String get systemHub;

  /// No description provided for @diagnostics.
  ///
  /// In en, this message translates to:
  /// **'Diagnostics'**
  String get diagnostics;

  /// No description provided for @tenants.
  ///
  /// In en, this message translates to:
  /// **'Tenants'**
  String get tenants;

  /// No description provided for @security.
  ///
  /// In en, this message translates to:
  /// **'Security'**
  String get security;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @impersonateTenant.
  ///
  /// In en, this message translates to:
  /// **'Impersonate Tenant'**
  String get impersonateTenant;

  /// No description provided for @mandatoryInduction.
  ///
  /// In en, this message translates to:
  /// **'MANDATORY INDUCTION'**
  String get mandatoryInduction;

  /// No description provided for @beforeYouAreGrantedAccessTo.
  ///
  /// In en, this message translates to:
  /// **'Before you are granted access to the Ecosystem, you must explicitly acknowledge your operational responsibilities.'**
  String get beforeYouAreGrantedAccessTo;

  /// No description provided for @englishEn.
  ///
  /// In en, this message translates to:
  /// **'English (en)'**
  String get englishEn;

  /// No description provided for @franAisFr.
  ///
  /// In en, this message translates to:
  /// **'Français (fr)'**
  String get franAisFr;

  /// No description provided for @engageGlobalCodeBlack.
  ///
  /// In en, this message translates to:
  /// **'ENGAGE GLOBAL CODE BLACK'**
  String get engageGlobalCodeBlack;

  /// No description provided for @constructNewRole.
  ///
  /// In en, this message translates to:
  /// **'+ Construct New Role'**
  String get constructNewRole;

  /// No description provided for @shiftsAutomaticallyStaffed.
  ///
  /// In en, this message translates to:
  /// **'Shifts Automatically Staffed'**
  String get shiftsAutomaticallyStaffed;

  /// No description provided for @surgeBudgetDeployed.
  ///
  /// In en, this message translates to:
  /// **'Surge Budget Deployed'**
  String get surgeBudgetDeployed;

  /// No description provided for @regionalMarginProtected.
  ///
  /// In en, this message translates to:
  /// **'Regional Margin Protected'**
  String get regionalMarginProtected;

  /// No description provided for @crisesAutoRoutedToRn.
  ///
  /// In en, this message translates to:
  /// **'Crises Auto-Routed to RN'**
  String get crisesAutoRoutedToRn;

  /// No description provided for @toxicWorkersHiddenLowTrust.
  ///
  /// In en, this message translates to:
  /// **'Toxic Workers Hidden (Low Trust)'**
  String get toxicWorkersHiddenLowTrust;

  /// No description provided for @executeMacroOverride.
  ///
  /// In en, this message translates to:
  /// **'EXECUTE MACRO OVERRIDE'**
  String get executeMacroOverride;

  /// No description provided for @initiateTermination.
  ///
  /// In en, this message translates to:
  /// **'INITIATE TERMINATION'**
  String get initiateTermination;

  /// No description provided for @overrideLockout.
  ///
  /// In en, this message translates to:
  /// **'OVERRIDE LOCKOUT'**
  String get overrideLockout;

  /// No description provided for @rnPatientsScopeActive.
  ///
  /// In en, this message translates to:
  /// **'RN Patients Scope Active'**
  String get rnPatientsScopeActive;

  /// No description provided for @rnInboxThreadActive.
  ///
  /// In en, this message translates to:
  /// **'RN Inbox Thread Active'**
  String get rnInboxThreadActive;

  /// No description provided for @rnProfileActive.
  ///
  /// In en, this message translates to:
  /// **'RN Profile Active'**
  String get rnProfileActive;

  /// No description provided for @coordinatorStaffActive.
  ///
  /// In en, this message translates to:
  /// **'Coordinator Staff Active'**
  String get coordinatorStaffActive;

  /// No description provided for @coordinatorApprovalsActive.
  ///
  /// In en, this message translates to:
  /// **'Coordinator Approvals Active'**
  String get coordinatorApprovalsActive;

  /// No description provided for @coordinatorProfileActive.
  ///
  /// In en, this message translates to:
  /// **'Coordinator Profile Active'**
  String get coordinatorProfileActive;

  /// No description provided for @managerDirectoryActive.
  ///
  /// In en, this message translates to:
  /// **'Manager Directory Active'**
  String get managerDirectoryActive;

  /// No description provided for @managerSystemActive.
  ///
  /// In en, this message translates to:
  /// **'Manager System Active'**
  String get managerSystemActive;

  /// No description provided for @managerExecuteActive.
  ///
  /// In en, this message translates to:
  /// **'Manager Execute Active'**
  String get managerExecuteActive;

  /// No description provided for @mtClientsActive.
  ///
  /// In en, this message translates to:
  /// **'MT Clients Active'**
  String get mtClientsActive;

  /// No description provided for @mtMessagesActive.
  ///
  /// In en, this message translates to:
  /// **'MT Messages Active'**
  String get mtMessagesActive;

  /// No description provided for @primecareMobile.
  ///
  /// In en, this message translates to:
  /// **'PrimeCare Mobile'**
  String get primecareMobile;
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
      <String>['en', 'fr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'fr':
      return AppLocalizationsFr();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
