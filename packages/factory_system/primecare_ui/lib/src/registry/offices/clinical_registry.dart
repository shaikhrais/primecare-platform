// Layer: 01_INFRASTRUCTURE
import 'package:flutter_core/00_B_flutter_core.dart';
import 'base_office_registry.dart';

class ClinicalRegistry extends OfficeScreenRegistry {
  @override
  void bootstrap() {
    registerRoute(ClinicalRoutes.clinicalDirectorDashboard, PrimeCareForm.clinicalDirectorDashboard);
    registerRoute(ClinicalRoutes.intakeCoordinatorDashboard, PrimeCareForm.intakeCoordinatorDashboard);
    registerRoute(ClinicalRoutes.nurseDashboard, PrimeCareForm.nurseDashboard);
    registerRoute(ClinicalRoutes.therapistDashboard, PrimeCareForm.therapistDashboard);
    registerRoute(ClinicalRoutes.pswDashboard, PrimeCareForm.pswDashboard);
    registerRoute(ClinicalRoutes.socialWorkerDashboard, PrimeCareForm.socialWorkerDashboard);
    
    // Also include Office routes that are clinical in nature
    registerRoute(OfficeRoutes.schedulerDashboard, PrimeCareForm.schedulerDashboard);
    registerRoute(OfficeRoutes.billingAdminDashboard, PrimeCareForm.billingAdminDashboard);
    registerRoute(OfficeRoutes.hrHiringDashboard, PrimeCareForm.hrHiringDashboard);
    registerRoute(OfficeRoutes.receptionistDashboard, PrimeCareForm.receptionistDashboard);
  }

  @override
  Map<String, Map<String, dynamic>> get registryJson => {
        'clinical_director': {
          'title': 'Clinical Excellence Gateway',
          'subtitle': 'Quality of Care • Patient Safety • Clinical Standards',
          'route': ClinicalRoutes.clinicalDirectorDashboard,
          'componentLabels': ['Aura HUD', 'Clinical KPI Grid', 'Incident Report Log', 'Patient Safety Overview'],
          'kpis': [
            {
              'title': 'Incident Rate',
              'value': '0.1%',
              'deltaSuffix': 'Goal: < 0.5%',
              'icon': 'activity',
              'iconColor': 'green',
            },
          ],
        },
        // We can add the other clinical JSON config here when defined
      };
}
