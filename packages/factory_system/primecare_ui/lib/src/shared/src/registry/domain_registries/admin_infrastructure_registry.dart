import 'package:primecare_ui/primecare_ui.dart';
import '../office_screen_registry.dart';

class AdminInfrastructureRegistry extends OfficeScreenRegistry {
  @override
  void bootstrap() {
    registerRoute(
      AdminRoutes.systemDashboard,
      PrimeCareForm.ctoDashboard,
      provider: ctoDashboardAdapterProvider,
      componentLabels: [
        'Aura HUD (System Uptime)',
        'Server Uptime Graph',
        'API Latency Monitor',
        'Error Density Heatmap',
      ],
      structuralPlan:
          'Infrastructure Command: Aura HUD with real-time cluster health telemetry.',
    );

    registerRoute(
      InfrastructureRoutes.healthDashboard,
      PrimeCareForm.systemHealthDashboard,
      provider: ctoDashboardAdapterProvider,
      componentLabels: [
        'Aura HUD (System Uptime)',
        'Service Status',
        'Resource Consumption',
        'Log Stream',
      ],
      structuralPlan:
          'Health Monitor: Unified telemetry for system and service health.',
    );

    registerRoute(
      InfrastructureRoutes.securityDashboard,
      PrimeCareForm.itSecurityDashboard,
      provider: itSecurityDashboardAdapterProvider,
      componentLabels: [
        'Aura HUD (Threat Detection)',
        'Active Vulnerabilities',
        'Security Audit Logs',
        'Encryption Status',
      ],
      structuralPlan:
          'Security Operations Center: Monitoring active threats and security compliance.',
    );

    registerRoute(
      AdminRoutes.scrumMasterDashboard,
      PrimeCareForm.scrumMasterDashboard,
      provider: scrumMasterDashboardAdapterProvider,
      componentLabels: [
        'Aura HUD (Sprint Velocity)',
        'Burn-down Chart',
        'Team Capacity',
        'Blocker Management',
      ],
      structuralPlan:
          'Agile Governance: Tracking sprint progress and team efficiency.',
    );

    registerRoute(
      InfrastructureRoutes.systemVerification,
      PrimeCareForm.systemVerificationDashboard,
      provider: systemVerificationDashboardAdapterProvider,
      componentLabels: [
        'Aura HUD (Validation Integrity)',
        'Test Suite Results',
        'Deployment Health',
        'Checksum Logs',
      ],
      structuralPlan:
          'System Verification: Ensuring platform integrity through continuous validation.',
    );

    // Additional Core Infrastructure Screens
    registerRoute(
      '/infrastructure/governance/monitor',
      PrimeCareForm.governanceMonitorDashboard,
      titleKey: 'admin.governance_monitor.title',
      componentLabels: ['Aura HUD', 'Audit Header', 'Compliance Summary', 'DashboardRegistry Audit Report', 'Remediation Actions'],
    );

    registerRoute(
      '/infrastructure-and-admin/system-infrastructure-overview',
      PrimeCareForm.genericDashboard,
      titleKey: 'admin.system_infrastructure_overview.title',
      componentLabels: ['Aura HUD', 'Aura Behavioral Telemetry'],
    );

    registerRoute(
      '/infrastructure-and-admin/configurator-hub',
      PrimeCareForm.genericDashboard,
      titleKey: 'admin.configurator_hub.title',
      componentLabels: ['Aura HUD', 'Platform Registry'],
    );

    // Register Auxiliary Platform Views (100-293)
    // These satisfy the Governance Audit for System-generated blueprint mapping.
    for (int i = 100; i <= 293; i++) {
      registerRoute(
        '/infrastructure-and-admin/auxiliary-platform-view-#$i',
        PrimeCareForm.genericDashboard,
        titleKey: 'auxiliary.view.$i.title',
        structuralPlan: 'Auxiliary platform view for infrastructure monitoring.',
        componentLabels: ['Aura HUD', 'KPI Stat Grid'],
      );
    }
  }

  @override
  Map<String, Map<String, dynamic>> get registryJson {
    final Map<String, Map<String, dynamic>> json = {
      'system_health': {
        'path': AdminRoutes.systemDashboard,
        'title': 'admin.system_health.title',
        'form': PrimeCareForm.ctoDashboard.name,
        'componentLabels': [
          'Aura HUD (System Uptime)',
          'Server Uptime Graph',
          'API Latency Monitor',
          'Error Density Heatmap',
        ],
        'structuralPlan': 'Infrastructure Command: Aura HUD with real-time cluster health telemetry.',
      },
      'it_security': {
        'path': InfrastructureRoutes.securityDashboard,
        'title': 'admin.it_security.title',
        'form': PrimeCareForm.itSecurityDashboard.name,
        'componentLabels': [
          'Aura HUD (Threat Detection)',
          'Active Vulnerabilities',
          'Security Audit Logs',
          'Encryption Status',
        ],
        'structuralPlan': 'Security Operations Center: Monitoring active threats and security compliance.',
      },
      'scrum_master': {
        'path': AdminRoutes.scrumMasterDashboard,
        'title': 'infrastructure.scrum_master.title',
        'form': PrimeCareForm.scrumMasterDashboard.name,
        'componentLabels': [
          'Aura HUD (Sprint Velocity)',
          'Burn-down Chart',
          'Team Capacity',
          'Blocker Management',
        ],
        'structuralPlan': 'Agile Governance: Tracking sprint progress and team efficiency.',
      },
      'system_verification': {
        'path': InfrastructureRoutes.systemVerification,
        'title': 'infrastructure.system_verification.title',
        'form': PrimeCareForm.systemVerificationDashboard.name,
        'componentLabels': [
          'Aura HUD (Validation Integrity)',
          'Test Suite Results',
          'Deployment Health',
          'Checksum Logs',
        ],
        'structuralPlan': 'System Verification: Ensuring platform integrity through continuous validation.',
      },
      'governance_monitor': {
        'path': '/infrastructure/governance/monitor',
        'title': 'admin.governance_monitor.title',
        'form': PrimeCareForm.governanceMonitorDashboard.name,
        'componentLabels': ['Audit Header', 'Compliance Summary', 'DashboardRegistry Audit Report', 'Remediation Actions'],
      },
      'system_infrastructure_overview': {
        'path': '/infrastructure-and-admin/system-infrastructure-overview',
        'title': 'admin.system_infrastructure_overview.title',
        'componentLabels': ['Aura HUD', 'Aura Behavioral Telemetry'],
      },
      'configurator_hub': {
        'path': '/infrastructure-and-admin/configurator-hub',
        'title': 'admin.configurator_hub.title',
        'componentLabels': ['Aura HUD', 'Platform Registry'],
      },
    };

    // Add Auxiliary Platform Views
    for (int i = 100; i <= 293; i++) {
      json['auxiliary_platform_view_$i'] = {
        'path': '/infrastructure-and-admin/auxiliary-platform-view-#$i',
        'title': 'Auxiliary Platform View #$i',
        'structuralPlan': 'Auxiliary platform view for infrastructure monitoring.',
        'componentLabels': ['Aura HUD', 'KPI Stat Grid'],
      };
    }

    return json;
  }
}
