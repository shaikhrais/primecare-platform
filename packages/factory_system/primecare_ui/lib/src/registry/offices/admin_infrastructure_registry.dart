// Layer: 01_INFRASTRUCTURE
import 'package:flutter_core/flutter_core.dart';
import 'base_office_registry.dart';

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
  }

  @override
  Map<String, Map<String, dynamic>> get registryJson => {
    'system_health': {
      'path': AdminRoutes.systemDashboard,
      'title': 'admin.system_health.title',
      'form': PrimeCareForm.ctoDashboard.name,
    },
    'it_security': {
      'path': InfrastructureRoutes.securityDashboard,
      'title': 'admin.it_security.title',
      'form': PrimeCareForm.itSecurityDashboard.name,
    },
    'scrum_master': {
      'path': AdminRoutes.scrumMasterDashboard,
      'title': 'infrastructure.scrum_master.title',
      'form': PrimeCareForm.scrumMasterDashboard.name,
    },
    'system_verification': {
      'path': InfrastructureRoutes.systemVerification,
      'title': 'infrastructure.system_verification.title',
      'form': PrimeCareForm.systemVerificationDashboard.name,
    },
  };
}
