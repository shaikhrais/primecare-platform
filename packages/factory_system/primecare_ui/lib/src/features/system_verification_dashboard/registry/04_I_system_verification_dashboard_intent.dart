// Layer: 04_REGISTRY_INTENT
import 'package:flutter_core/00_B_flutter_core.dart';
import '../presentation/widgets/05_U_system_verification_dashboard_screen.dart';

class SystemVerificationDashboardIntent extends AppScreenIntent {
  const SystemVerificationDashboardIntent();

  @override
  String get name => 'system_verification_dashboard';

  @override
  String get route => '/offices/corporate/roles/system_verification/dashboard';

  @override
  String get title => 'System Verification Dashboard';

  @override
  PlatformRole get requiredRole => PlatformRole.systemVerification;

  @override
  dynamic get provider => systemVerificationAdapterProvider;

  @override
  Widget build(BuildContext context) => const SystemVerificationDashboardScreen();
}

