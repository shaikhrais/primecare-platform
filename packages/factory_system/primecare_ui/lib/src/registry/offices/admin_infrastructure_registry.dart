// Layer: 01_INFRASTRUCTURE
import 'package:flutter_core/00_B_flutter_core.dart';
import 'base_office_registry.dart';

class AdminInfrastructureRegistry extends OfficeScreenRegistry {
  @override
  void bootstrap() {
    registerRoute(InfrastructureRoutes.healthDashboard, PrimeCareForm.infrastructureHealth);
    registerRoute(InfrastructureRoutes.systemDashboard, PrimeCareForm.systemInfrastructure);
    registerRoute(InfrastructureRoutes.configurationDashboard, PrimeCareForm.configurator);
    
    registerRoute(AdminRoutes.adminDashboard, PrimeCareForm.adminDashboard);
    registerRoute(AdminRoutes.systemDashboard, PrimeCareForm.systemInfrastructure);
  }

  @override
  Map<String, Map<String, dynamic>> get registryJson => {
        'scrum_master': {
          'title': 'System & Project Pulse',
          'subtitle': 'Development Velocity • Sprint Monitoring',
          'route': CommonRoutes.scrumMasterDashboard,
          'kpis': [
            {
              'title': 'Sprint Velocity',
              'value': '42',
              'deltaSuffix': 'Points',
              'icon': 'zap',
              'iconColor': 'amber',
            },
          ],
        },
        'guest': {
          'title': 'PrimeCare Welcome',
          'subtitle': 'Explore Platform Capabilities',
          'route': CommonRoutes.guestDashboard,
          'kpis': <Map<String, dynamic>>[],
        },
      };
}
