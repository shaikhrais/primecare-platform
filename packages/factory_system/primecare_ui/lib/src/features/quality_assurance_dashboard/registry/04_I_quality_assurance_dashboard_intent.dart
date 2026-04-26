// Layer: 04_REGISTRY_INTENT
import 'package:flutter_core/00_B_flutter_core.dart';
import '../presentation/widgets/05_U_quality_assurance_dashboard_screen.dart';

class QualityAssuranceDashboardIntent extends AppScreenIntent {
  QualityAssuranceDashboardIntent();

  @override
  String get name => 'quality_assurance_dashboard';

  @override
  String get route => '/offices/corporate/roles/quality_assurance/dashboard';

  @override
  String get title => 'dashboards.qualityassurance.title';

  @override
  PlatformRole get requiredRole => PlatformRole.qualityAssurance;

  @override
  dynamic get provider => qualityAssuranceDashboardAdapterProvider;

  @override
  Widget build(BuildContext context) => const QualityAssuranceDashboardScreen();
}
