// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'PrimeCare Hub';

  @override
  String get ok => 'OK';

  @override
  String get cancel => 'Cancel';

  @override
  String get save => 'Save';

  @override
  String get success => 'Success';

  @override
  String get error => 'Error';

  @override
  String get welcomeBack => 'Welcome Back, First Responder!';

  @override
  String get nextShiftAnnouncement =>
      'Your next shift begins in 2h 15m. You have 2 unread announcements.';

  @override
  String get performanceMetrics => 'Performance Metrics';

  @override
  String get weeklyHoursLabel => 'Weekly Hours';

  @override
  String get complianceLabel => 'Compliance';

  @override
  String get surgeActiveLabel => 'Surge Active';

  @override
  String get quickAccessNodes => 'Quick Access Nodes';

  @override
  String get secureInbox => 'Secure Inbox';

  @override
  String get dailyTimeline => 'Daily Timeline';

  @override
  String get trainingHub => 'Training Hub';

  @override
  String get sosTrigger => 'SOS Trigger';

  @override
  String get viewClients => 'View Clients';

  @override
  String get organizationalFeed => 'Organizational Feed';

  @override
  String get myShiftsTitle => 'My Shifts';

  @override
  String get highDemandAlertTitle => 'High Demand Alert';

  @override
  String get highDemandAlertDesc =>
      'Surge pricing active for evening shifts (+1.5x payout rate).';

  @override
  String get today => 'Today';

  @override
  String get shiftCountLabel => '3 Shifts';

  @override
  String get shiftAckSuccess => 'Shift acknowledged successfully.';

  @override
  String get undo => 'UNDO';

  @override
  String get themeConfiguration => 'Theme Configuration';

  @override
  String get selectThemeDesc =>
      'Select your preferred visual layout. Changes are applied globally.';

  @override
  String get lightThemeLabel => 'Light (Enterprise Slate)';

  @override
  String get darkThemeLabel => 'Dark (Obsidian)';

  @override
  String get highContrastLabel => 'High Contrast (Medical)';
}
