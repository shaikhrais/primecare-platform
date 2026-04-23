// Layer: 04_REGISTRY_INTENT
import 'package:flutter_core/00_B_flutter_core.dart';
import '../presentation/widgets/05_U_clinical_director_dashboard_screen.dart';

class ClinicalDirectorDashboardIntent extends AppScreenIntent {
  const ClinicalDirectorDashboardIntent();

  @override
  String get name => 'clinical_director_dashboard';

  @override
  String get route => '/offices/clinical/roles/clinical_director/dashboard';

  @override
  String get title => 'Clinical Director Dashboard';

  @override
  PlatformRole get requiredRole => PlatformRole.clinicalDirector;

  @override
  dynamic get provider => clinicalDirectorDashboardAdapterProvider;

  @override
  List<String> get componentLabels => ['Clinical Safety Score', 'Staffing Heatmap', 'Protocol Compliance'];

  @override
  Widget build(BuildContext context) => const ClinicalDirectorDashboardScreen();
}

