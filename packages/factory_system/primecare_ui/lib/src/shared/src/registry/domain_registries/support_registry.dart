import 'package:primecare_ui/primecare_ui.dart';
import '../office_screen_registry.dart';

class SupportRegistry extends OfficeScreenRegistry {
  @override
  void bootstrap() {
    _registerSupportRoles();
  }

  void _registerSupportRoles() {
    registerRoute(
      '/offices/roles/support-team/dashboard',
      PrimeCareForm.genericDashboard,
      titleKey: LocaleKeys.dashboards_support_title,
      componentLabels: [
        'Aura HUD',
        'Support Ticket Grid',
        'Resolution Latency Monitor',
        'Active Session Map',
      ],
      structuralPlan: 'Support Hub: Real-time ticket lifecycle and session health monitoring.',
    );

    registerRoute(
      '/offices/roles/customer-support/dashboard',
      PrimeCareForm.genericDashboard,
      titleKey: LocaleKeys.support_customer_support_dashboard_title,
      componentLabels: [
        'Aura HUD',
        'NPS Scorecard',
        'Omnichannel Feed',
        'CSAT Trend Analysis',
      ],
      structuralPlan: 'Customer Excellence Portal: Focus on sentiment analysis and response quality metrics.',
    );
    registerRoute(
      ClinicalRoutes.qaDashboard,
      PrimeCareForm.qaDashboard,
      provider: qaDashboardAdapterProvider,
      componentLabels: [
        'Aura HUD (Drift Score)',
        'Registry Parity Monitor',
        'Blueprint Compliance Audit',
        'Remediation Queue',
      ],
      structuralPlan: 'Governance Monitoring: Real-time drift detection and blueprint compliance auditing.',
    );
  }

  @override
  Map<String, Map<String, dynamic>> get registryJson => {
    'SCREEN_SUPPORT_TEAM': {
      'title': LocaleKeys.dashboards_support_title,
      'path': '/offices/roles/support-team/dashboard',
      'componentLabels': [
        'Aura HUD',
        'Support Ticket Grid',
        'Resolution Latency Monitor',
        'Active Session Map',
      ],
    },
    'SCREEN_CUSTOMER_SUPPORT': {
      'title': LocaleKeys.support_customer_support_dashboard_title,
      'path': '/offices/roles/customer-support/dashboard',
      'componentLabels': [
        'Aura HUD',
        'NPS Scorecard',
        'Omnichannel Feed',
        'CSAT Trend Analysis',
      ],
    },
    'qa': {
      'title': 'Quality Assurance Dashboard',
      'route': ClinicalRoutes.qaDashboard,
      'componentLabels': [
        'Aura HUD (Drift Score)',
        'Registry Parity Monitor',
        'Blueprint Compliance Audit',
        'Remediation Queue',
      ],
      'structuralPlan': 'Governance Monitoring: Real-time drift detection and blueprint compliance auditing.',
    },
  };
}
