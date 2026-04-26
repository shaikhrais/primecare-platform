// Layer: 04_REGISTRY_INTENT
import 'package:flutter_core/00_B_flutter_core.dart';
import '../presentation/widgets/05_U_training_director_certificate_dashboard_screen.dart';

class TrainingDirectorCertificateDashboardIntent extends AppScreenIntent {
  TrainingDirectorCertificateDashboardIntent();

  @override
  String get name => 'training_director_certificate_dashboard';

  @override
  String get route =>
      '/offices/corporate/roles/training_director_certificate/dashboard';

  @override
  String get title => 'dashboards.trainingdirectorcertificate.title';

  @override
  PlatformRole get requiredRole => PlatformRole.trainingDirectorCertificate;

  @override
  dynamic get provider => trainingDirectorCertMetricsProvider;

  @override
  Widget build(BuildContext context) =>
      const TrainingDirectorCertificateDashboardScreen();
}
