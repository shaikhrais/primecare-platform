// Layer: 04_REGISTRY_INTENT
import 'package:flutter_core/00_B_flutter_core.dart';
import '../presentation/widgets/05_U_training_hub_dashboard_screen.dart';

class TrainingHubDashboardIntent extends AppScreenIntent {
  const TrainingHubDashboardIntent();

  @override
  String get name => 'training_hub_dashboard';

  @override
  String get route => '/offices/corporate/roles/training_hub/dashboard';

  @override
  String get title => 'Training Hub Dashboard';

  @override
  PlatformRole get requiredRole => PlatformRole.trainingHub;

  @override
  dynamic get provider => trainingHubAdapterProvider;

  @override
  Widget build(BuildContext context) => const TrainingHubDashboardScreen();
}

