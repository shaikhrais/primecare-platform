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
