// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appName => 'PrimeCare Hub';

  @override
  String get ok => 'OK';

  @override
  String get cancel => 'Annuler';

  @override
  String get save => 'Enregistrer';

  @override
  String get success => 'Succès';

  @override
  String get error => 'Erreur';

  @override
  String get welcomeBack => 'Bon retour, Premier Répondant !';

  @override
  String get nextShiftAnnouncement =>
      'Votre prochain quart de travail commence dans 2h 15m. Vous avez 2 annonces non lues.';

  @override
  String get performanceMetrics => 'Indicateurs de Performance';

  @override
  String get weeklyHoursLabel => 'Heures Hebdom.';

  @override
  String get complianceLabel => 'Conformité';

  @override
  String get surgeActiveLabel => 'Surge Actif';

  @override
  String get quickAccessNodes => 'Nœuds d\'Accès Rapide';

  @override
  String get secureInbox => 'Boîte Sécurisée';

  @override
  String get dailyTimeline => 'Chronologie du Jour';

  @override
  String get trainingHub => 'Centre de Formation';

  @override
  String get sosTrigger => 'Déclencheur SOS';

  @override
  String get viewClients => 'Voir les Clients';

  @override
  String get organizationalFeed => 'Flux Organisationnel';

  @override
  String get myShiftsTitle => 'Mes Quarts';

  @override
  String get highDemandAlertTitle => 'Alerte de Forte Demande';

  @override
  String get highDemandAlertDesc =>
      'Prix de forte demande actif pour les quarts du soir (taux de paiement +1.5x).';

  @override
  String get today => 'Aujourd\'hui';

  @override
  String get shiftCountLabel => '3 Quarts';

  @override
  String get shiftAckSuccess => 'Quart de travail acquitté avec succès.';

  @override
  String get undo => 'ANNULER';

  @override
  String get themeConfiguration => 'Configuration du Thème';

  @override
  String get selectThemeDesc =>
      'Sélectionnez votre disposition visuelle préférée. Les modifications s\'appliquent globalement.';

  @override
  String get lightThemeLabel => 'Clair (Ardoise)';

  @override
  String get darkThemeLabel => 'Sombre (Obsidienne)';

  @override
  String get highContrastLabel => 'Contraste Élevé';
}
