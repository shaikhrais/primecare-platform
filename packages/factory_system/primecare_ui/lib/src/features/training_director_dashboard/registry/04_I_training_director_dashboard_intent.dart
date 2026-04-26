// Layer: 04_REGISTRY_INTENT
import 'package:flutter_core/00_B_flutter_core.dart';
import '../presentation/widgets/05_U_training_director_dashboard_screen.dart';

class TrainingDirectorDashboardIntent extends AppScreenIntent {
  TrainingDirectorDashboardIntent();

  @override
  String get name => 'training_director_dashboard';

  @override
  String get route => '/offices/corporate/roles/training_director/dashboard';

  @override
  String get title => 'dashboards.trainingdirector.title';

  @override
  PlatformRole get requiredRole => PlatformRole.trainingDirector;

  @override
  dynamic get provider => trainingMetricsProvider;

  @override
  Widget build(BuildContext context) => const TrainingDirectorDashboardScreen();
}
