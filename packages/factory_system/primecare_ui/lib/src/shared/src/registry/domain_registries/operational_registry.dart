import 'package:primecare_ui/primecare_ui.dart';
import '../office_screen_registry.dart';

class OperationalRegistry extends OfficeScreenRegistry {
  @override
  void bootstrap() {
    _registerMetadataScreens();
    _registerOfficeRoles();
  }

  void _registerOfficeRoles() {
    registerRoute(
      OfficeRoutes.receptionistDashboard,
      PrimeCareForm.receptionistDashboard,
      provider: receptionistDashboardAdapterProvider,
      titleKey: LocaleKeys.receptionist_dashboard_title,
      componentLabels: [
        'Aura HUD',
        'Appointment Calendar',
        'Check-in Queue',
        'Directory Search',
      ],
      structuralPlan:
          'Front-Office Command: Aura HUD with visitor flow telemetry. Prioritizes real-time check-in management and institutional directory access.',
    );
  }

  void _registerMetadataScreens() {
    registerRoute(
      '/admin-settings',
      PrimeCareForm.genericDashboard,
      titleKey: 'LocaleKeys.Registries\operational_AdminSettings',
      componentLabels: ['Aura HUD', 'Operational Metric', 'Drift Detection'],
    );
    registerRoute(
      '/architecture-governance',
      PrimeCareForm.genericDashboard,
      titleKey: 'LocaleKeys.Registries\operational_ArchitectureGovernance',
      componentLabels: ['Aura HUD', 'Operational Metric', 'Drift Detection'],
    );
    registerRoute(
      '/logistics-hub',
      PrimeCareForm.genericDashboard,
      titleKey: 'LocaleKeys.Registries\operational_LogisticsHub',
      componentLabels: ['Aura HUD', 'Operational Metric', 'Drift Detection'],
    );
    registerRoute(
      '/operational/staffing-director',
      PrimeCareForm.genericDashboard,
      titleKey: 'LocaleKeys.Registries\operational_StaffingDirector',
      componentLabels: [
        'Aura HUD',
        'Staffing Forecast Grid',
        'Shift Optimization Heatmap',
        'Credentialing Pipeline'
      ],
    );
    registerRoute(
      '/operational/regional-manager',
      PrimeCareForm.genericDashboard,
      titleKey: 'LocaleKeys.Registries\operational_RegionalManager',
      componentLabels: [
        'Aura HUD',
        'Regional KPI Matrix',
        'Branch Health Scorecard',
        'Incident Aggregator'
      ],
    );
  }

  @override
  Map<String, Map<String, dynamic>> get registryJson => {
    'SCREEN_2': {
      'title': 'LocaleKeys.Registries\operational_AdminSettings',
      'path': '/admin-settings',
      'componentLabels': ['Aura HUD', 'Operational Metric', 'Drift Detection'],
    },
    'SCREEN_3': {
      'title': 'LocaleKeys.Registries\operational_ArchitectureGovernance',
      'path': '/architecture-governance',
      'componentLabels': ['Aura HUD', 'Operational Metric', 'Drift Detection'],
    },
    'SCREEN_8': {
      'title': 'LocaleKeys.Registries\operational_LogisticsHub',
      'path': '/logistics-hub',
      'componentLabels': ['Aura HUD', 'Operational Metric', 'Drift Detection'],
    },
    'SCREEN_STAFFING_DIRECTOR': {
      'title': 'LocaleKeys.Registries\operational_StaffingDirector',
      'path': '/operational/staffing-director',
      'componentLabels': [
        'Aura HUD',
        'Staffing Forecast Grid',
        'Shift Optimization Heatmap',
        'Credentialing Pipeline'
      ],
    },
    'SCREEN_REGIONAL_MANAGER': {
      'title': 'LocaleKeys.Registries\operational_RegionalManager',
      'path': '/operational/regional-manager',
      'componentLabels': [
        'Aura HUD',
        'Regional KPI Matrix',
        'Branch Health Scorecard',
        'Incident Aggregator'
      ],
    },
    'SCREEN_RECEPTIONIST': {
      'title': 'LocaleKeys.receptionist_dashboard_title',
      'path': '/offices/roles/receptionist/dashboard',
      'componentLabels': [
        'Aura HUD',
        'Appointment Calendar',
        'Check-in Queue',
        'Directory Search'
      ],
    },
  };
}
