// Layer: 04_REGISTRY_INTENT
import 'package:flutter_core/00_B_flutter_core.dart';
import '../presentation/widgets/05_U_family_dashboard_screen.dart';

class FamilyDashboardIntent extends AppScreenIntent {
  FamilyDashboardIntent();

  @override
  String get name => 'family_dashboard';

  @override
  String get route => '/offices/corporate/roles/family/dashboard';

  @override
  String get title => 'Family Dashboard';

  @override
  PlatformRole get requiredRole => PlatformRole.familyMember;

  @override
  dynamic get provider => familyDashboardAdapterProvider;

  @override
  Widget build(BuildContext context) => const FamilyDashboardScreen();
}
