import '../screen_metadata.dart';

class SupportRegistryRegistry {
  static const Map<String, ScreenMetadata> screens = {
        'SCREEN_OFFICES_ROLES_SUPPORT_TEAM_DASHBOARD_': ScreenMetadata(
      id: 'SCREEN_OFFICES_ROLES_SUPPORT_TEAM_DASHBOARD_',
      title: '/offices/roles/support-team/dashboard',
      featureName: '/offices/roles/support-team/dashboard',
      routePath: '/offices/roles/support-team/dashboard',
      office: 'Support',
      role: 'Staff',
      allowedRoles: ['Staff', 'Admin'],
      lifecycleStatus: LifecycleStatus.completed,
      isRenderOk: true,
      userApprovedLayout: true,
      isVirtual: true,
      sourcePath: 'virtual',
      implementedComponents: ["Aura HUD","Support Ticket Grid","Resolution Latency Monitor","Active Session Map"],
    ),
        'SCREEN_OFFICES_ROLES_CUSTOMER_SUPPORT_DASHBOARD_': ScreenMetadata(
      id: 'SCREEN_OFFICES_ROLES_CUSTOMER_SUPPORT_DASHBOARD_',
      title: '/offices/roles/customer-support/dashboard',
      featureName: '/offices/roles/customer-support/dashboard',
      routePath: '/offices/roles/customer-support/dashboard',
      office: 'Support',
      role: 'Staff',
      allowedRoles: ['Staff', 'Admin'],
      lifecycleStatus: LifecycleStatus.completed,
      isRenderOk: true,
      userApprovedLayout: true,
      isVirtual: true,
      sourcePath: 'virtual',
      implementedComponents: ["Aura HUD","NPS Scorecard","Omnichannel Feed","CSAT Trend Analysis"],
    ),
  };
}
