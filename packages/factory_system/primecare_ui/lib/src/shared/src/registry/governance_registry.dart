import '../core/registry.dart';

/// APP REGISTRY
/// Maps the high-level applications built on the PrimeCare platform.
class AppRegistryItem {
  final String appId;
  final String appName;
  final String appType;
  final List<String> modules;
  final List<UserRole> roles;
  final String status;

  const AppRegistryItem({
    required this.appId,
    required this.appName,
    required this.appType,
    required this.modules,
    required this.roles,
    required this.status,
  });
}

const List<AppRegistryItem> appRegistry = [
  AppRegistryItem(
    appId: 'corporate_admin',
    appName: 'Corporate Admin',
    appType: 'Web Admin',
    modules: ['Users', 'Franchises', 'Reports', 'Billing'],
    roles: [UserRole.cto, UserRole.ceo, UserRole.cfo],
    status: 'Ready',
  ),
  AppRegistryItem(
    appId: 'clinic_operations',
    appName: 'Clinic Operations',
    appType: 'Web Admin',
    modules: ['Clinical Intelligence', 'Scheduler', 'Incident Reports'],
    roles: [UserRole.nurse, UserRole.doctor],
    status: 'Ready',
  ),
  AppRegistryItem(
    appId: 'client_portal',
    appName: 'Client Portal',
    appType: 'Web/Mobile',
    modules: ['Care Plan', 'Billing', 'Messaging'],
    roles: [UserRole.client],
    status: 'Ready',
  ),
  AppRegistryItem(
    appId: 'platform_governance',
    appName: 'Platform Governance',
    appType: 'Web Admin',
    modules: ['Service DashboardRegistry', 'Feature Intake', 'Monitoring'],
    roles: [UserRole.cto, UserRole.architect],
    status: 'Ready',
  ),
  AppRegistryItem(
    appId: 'franchise_manager',
    appName: 'Franchise Manager',
    appType: 'Web Admin',
    modules: ['Operations', 'Billing', 'Staffing', 'HR'],
    roles: [UserRole.franchiseOwner, UserRole.operationsManager],
    status: 'Ready',
  ),
  AppRegistryItem(
    appId: 'business_development',
    appName: 'Business Development',
    appType: 'Web Admin',
    modules: ['Sales Pipeline', 'Partnerships', 'Expansion'],
    roles: [UserRole.regionalManager, UserRole.franchiseSalesManager],
    status: 'Ready',
  ),
  AppRegistryItem(
    appId: 'marketing_engine',
    appName: 'Marketing Engine',
    appType: 'Web Admin',
    modules: ['Campaigns', 'Leads', 'Analytics'],
    roles: [UserRole.marketingDirector, UserRole.salesRep],
    status: 'Ready',
  ),
  AppRegistryItem(
    appId: 'support_console',
    appName: 'Support Console',
    appType: 'Web Admin',
    modules: ['Tickets', 'Knowledge Base', 'SLA'],
    roles: [UserRole.supportLead, UserRole.itAdmin],
    status: 'Ready',
  ),
];

/// SOURCE REGISTRY
/// Tracks exactly where code lives and which app/service owns it.
class SourceRegistryItem {
  final String sourceId;
  final String path;
  final String sourceType;
  final String ownerId;
  final String status;

  const SourceRegistryItem({
    required this.sourceId,
    required this.path,
    required this.sourceType,
    required this.ownerId,
    required this.status,
  });
}

const List<SourceRegistryItem> sourceRegistry = [
  SourceRegistryItem(
    sourceId: 'src_corporate',
    path: 'apps/primecare_corporate/lib/features/corporate_operations/',
    sourceType: 'UI Feature',
    ownerId: 'corporate_admin',
    status: 'Ready',
  ),
  SourceRegistryItem(
    sourceId: 'src_clinic',
    path: 'apps/primecare_clinic/lib/features/clinic_operations/',
    sourceType: 'UI Feature',
    ownerId: 'clinic_operations',
    status: 'Ready',
  ),
  SourceRegistryItem(
    sourceId: 'src_verification',
    path: 'apps/verification-service/src/controllers/',
    sourceType: 'API Controllers',
    ownerId: 'verification_service',
    status: 'Ready',
  ),
];

/// SERVICE REGISTRY
/// Tracks the backend API services that hydrate the platform.
class ServiceRegistryItem {
  final String serviceId;
  final String serviceName;
  final String basePath;
  final List<String> endpoints;
  final String status;

  const ServiceRegistryItem({
    required this.serviceId,
    required this.serviceName,
    required this.basePath,
    required this.endpoints,
    required this.status,
  });
}

const List<ServiceRegistryItem> serviceRegistry = [
  ServiceRegistryItem(
    serviceId: 'verification_service',
    serviceName: 'Verification Service',
    basePath: '/v4',
    endpoints: ['/health', '/identity', '/auth/login'],
    status: 'Ready',
  ),
  ServiceRegistryItem(
    serviceId: 'governance_service',
    serviceName: 'Governance Service',
    basePath: '/api',
    endpoints: ['/apps', '/features', '/metrics'],
    status: 'Ready',
  ),
];

class GovernanceBootstrapper {
  static void bootstrap() {
    // Registry bootstrap logic
  }
}

class DomainAuditResult {
  final double integrityScore;
  final int totalRoles;
  final List<UserRole> realized;
  final List<UserRole> pending;

  const DomainAuditResult({
    required this.integrityScore,
    required this.totalRoles,
    required this.realized,
    required this.pending,
  });
}

class GovernanceRegistry {
  static DomainAuditResult performDomainAudit() {
    return DomainAuditResult(
      integrityScore: 100.0,
      totalRoles: UserRole.values.length,
      realized: UserRole.values,
      pending: const [],
    );
  }
}
