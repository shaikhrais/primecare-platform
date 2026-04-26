// Layer: 04_REGISTRY_INTENT
import 'package:flutter_core/00_B_flutter_core.dart';
import '../presentation/widgets/05_U_family_member_dashboard_screen.dart';

class FamilyMemberDashboardIntent extends AppScreenIntent {
  FamilyMemberDashboardIntent();

  @override
  String get name => 'family_member_dashboard';

  @override
  String get route => '/portals/family_member/dashboard';

  @override
  String get title => 'dashboards.familymember.title';

  @override
  PlatformRole get requiredRole => PlatformRole.familyMember;

  @override
  dynamic get provider => familyMemberDashboardAdapterProvider;

  @override
  Widget build(BuildContext context) => const FamilyMemberDashboardScreen();
}
