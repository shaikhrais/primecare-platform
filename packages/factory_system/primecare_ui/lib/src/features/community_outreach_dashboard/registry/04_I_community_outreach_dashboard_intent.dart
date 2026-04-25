// Layer: 04_REGISTRY_INTENT
import 'package:flutter_core/00_B_flutter_core.dart';
import '../presentation/widgets/05_U_community_outreach_dashboard_screen.dart';

class CommunityOutreachDashboardIntent extends AppScreenIntent {
  CommunityOutreachDashboardIntent();

  @override
  String get name => 'community_outreach_dashboard';

  @override
  String get route => '/offices/corporate/roles/community_outreach/dashboard';

  @override
  String get title => 'Community Outreach Dashboard';

  @override
  PlatformRole get requiredRole => PlatformRole.communityOutreach;

  @override
  dynamic get provider => communityOutreachDashboardAdapterProvider;

  @override
  Widget build(BuildContext context) =>
      const CommunityOutreachDashboardScreen();
}
