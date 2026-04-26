import '../../core/models.dart';

/// 1. APP-WISE GOVERNANCE
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
    appId: 'APP-CORP-001',
    appName: 'Corporate Admin App',
    appType: 'Web Admin',
    modules: ['Users', 'Franchises', 'Reports', 'Billing'],
    roles: [UserRole.cto, UserRole.ceo], // Adjusted to match UserRole enum
    status: 'In Development',
  ),
  AppRegistryItem(
    appId: 'APP-PSW-001',
    appName: 'PSW Mobile App',
    appType: 'Mobile',
    modules: ['Shifts', 'Check In', 'Care Notes'],
    roles: [UserRole.psw],
    status: 'Draft',
  ),
];

/// 2. SOURCE-WISE GOVERNANCE
/// Tracks exactly where code lives and which app/service owns it.
class SourceRegistryItem {
  final String sourceId;
  final String path;
  final String sourceType;
  final String ownerAppOrService;
  final String status;

  const SourceRegistryItem({
    required this.sourceId,
    required this.path,
    required this.sourceType,
    required this.ownerAppOrService,
    required this.status,
  });
}

const List<SourceRegistryItem> sourceRegistry = [
  SourceRegistryItem(
    sourceId: 'SRC-001',
    path: 'apps/corporate_admin_app/lib/screens/users/',
    sourceType: 'UI Module',
    ownerAppOrService: 'APP-CORP-001',
    status: 'Ready',
  ),
  SourceRegistryItem(
    sourceId: 'SRC-002',
    path: 'services/shift_service/src/',
    sourceType: 'API Microservice',
    ownerAppOrService: 'SVC-SHIFT-001',
    status: 'In Development',
  ),
];

/// 3. MICROSERVICE-WISE GOVERNANCE
/// Tracks the backend API services that hydrate the platform.
class ServiceRegistryItem {
  final String serviceId;
  final String serviceName;
  final String basePath;
  final List<String> endpoints;
  final String databaseTables;
  final String status;

  const ServiceRegistryItem({
    required this.serviceId,
    required this.serviceName,
    required this.basePath,
    required this.endpoints,
    required this.databaseTables,
    required this.status,
  });
}

const List<ServiceRegistryItem> serviceRegistry = [
  ServiceRegistryItem(
    serviceId: 'SVC-AUTH-001',
    serviceName: 'Auth Service',
    basePath: '/api/auth',
    endpoints: [
      'POST /login',
      'POST /logout',
      'GET /me',
    ],
    databaseTables: 'users, sessions, roles',
    status: 'Ready',
  ),
  ServiceRegistryItem(
    serviceId: 'SVC-SHIFT-001',
    serviceName: 'Shift Service',
    basePath: '/api/shifts',
    endpoints: [
      'GET /shifts',
      'POST /shifts',
      'PUT /shifts/:id',
      'POST /shifts/:id/check-in',
    ],
    databaseTables: 'shifts, visits, checkins',
    status: 'In Development',
  ),
];
