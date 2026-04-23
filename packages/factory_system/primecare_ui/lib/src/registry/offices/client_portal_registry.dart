// Layer: 01_INFRASTRUCTURE
import 'package:flutter_core/00_B_flutter_core.dart';
import 'base_office_registry.dart';

class ClientPortalRegistry extends OfficeScreenRegistry {
  @override
  void bootstrap() {
    registerRoute(ClientRoutes.clientDashboard, PrimeCareForm.clientDashboard);
  }

  @override
  Map<String, Map<String, dynamic>> get registryJson => {
        'client': {
          'title': 'My Care Portal',
          'subtitle': 'Manage Appointments • Care Team • Health Updates',
          'route': ClientRoutes.clientDashboard,
          'kpis': [
            {
              'title': 'Next Appointment',
              'value': 'Oct 24',
              'deltaSuffix': '10:00 AM',
              'icon': 'calendar',
              'iconColor': 'blue',
            },
          ],
        },
        'family_member': {
          'title': 'Family Care Hub',
          'subtitle': 'Track Loved One Care • Billing • Communication',
          'route': ClientRoutes.familyMemberDashboard,
          'kpis': [
            {
              'title': 'Recent Update',
              'value': '2h ago',
              'deltaSuffix': 'Stable Status',
              'icon': 'heart',
              'iconColor': 'red',
            },
          ],
        },
      };
}
