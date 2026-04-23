// Layer: 01_INFRASTRUCTURE
import 'package:flutter_core/00_B_flutter_core.dart';
import 'base_office_registry.dart';

class SupportRegistry extends OfficeScreenRegistry {
  @override
  void bootstrap() {
    registerRoute(SupportRoutes.customerSupportDashboard, PrimeCareForm.customerSupportDashboard);
    registerRoute(SupportRoutes.intakeCoordinatorDashboard, PrimeCareForm.intakeCoordinatorDashboard);
    registerRoute(SupportRoutes.qualityAssuranceDashboard, PrimeCareForm.qualityAssuranceDashboard);
  }

  @override
  Map<String, Map<String, dynamic>> get registryJson => {
        'quality_assurance': {
          'title': 'QA Command Center',
          'subtitle': 'Clinical Audits • Regulatory Compliance • Incident Management',
          'route': SupportRoutes.qualityAssuranceDashboard,
          'kpis': [
            {
              'title': 'Medication Errors',
              'value': '0.02%',
              'deltaSuffix': 'Below Target',
              'icon': 'shieldAlert',
              'iconColor': 'blue',
            },
          ],
        },
        'customer_support': {
          'title': 'Customer Support Pulse',
          'subtitle': 'Ticket Management • Client Satisfaction',
          'route': SupportRoutes.customerSupportDashboard,
          'kpis': [
            {
              'title': 'Open Tickets',
              'value': '24',
              'deltaSuffix': 'Avg wait: 4m',
              'icon': 'ticket',
              'iconColor': 'blue',
            },
          ],
        },
        'intake_coordinator': {
          'title': 'Patient Intake Hub',
          'subtitle': 'Referral Processing • Initial Assessments',
          'route': SupportRoutes.intakeCoordinatorDashboard,
          'kpis': [
            {
              'title': 'New Referrals',
              'value': '12',
              'deltaSuffix': 'Today',
              'icon': 'userPlus',
              'iconColor': 'teal',
            },
          ],
        },
      };
}
