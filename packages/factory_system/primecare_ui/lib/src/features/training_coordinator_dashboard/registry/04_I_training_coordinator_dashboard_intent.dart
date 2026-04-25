// Layer: 04_REGISTRY_INTENT
import 'package:flutter_core/00_B_flutter_core.dart';
import '../presentation/widgets/05_U_training_coordinator_dashboard_screen.dart';

class TrainingCoordinatorDashboardIntent extends AppScreenIntent {
  TrainingCoordinatorDashboardIntent();

  @override
  String get name => 'training_coordinator_dashboard';

  @override
  String get route => '/offices/corporate/roles/training_coordinator/dashboard';

  @override
  String get title => 'Training Coordinator Dashboard';

  @override
  PlatformRole get requiredRole => PlatformRole.trainingCoordinator;

  @override
  dynamic get provider => trainingCoordMetricsProvider;

  @override
  Widget build(BuildContext context) =>
      const TrainingCoordinatorDashboardScreen();
}
