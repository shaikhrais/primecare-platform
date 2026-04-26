import 'package:primecare_ui/primecare_ui.dart';

/// The institutional intent for the Governance Compliance Monitor.
/// This intent overrides the default build logic to render the high-fidelity
/// audit dashboard directly, bypassing the generic assembly engine.
class CorporateGovernanceDashboardIntent extends PrimeCareScreen {
  CorporateGovernanceDashboardIntent()
    : super(
        name: 'corporate_governance',
        title: 'Corporate Governance HUD',
        subtitle: 'Institutional integrity and architectural compliance audit.',
        requiredRole: PlatformRole.admin,
        route: InfrastructureRoutes.governanceMonitor,
        provider: corporateGovernanceDashboardAdapterProvider,
      );

  @override
  String get structuralPlan =>
      'Institutional Integrity Stack: Primary audit metrics in hero, detailed violation logs in list view, and self-healing remediation actions in footer.';

  @override
  List<String> get componentLabels => [
    'dashboards.corporategovernance.labels.compliance_hero',
    'dashboards.corporategovernance.labels.violation_logs',
    'dashboards.corporategovernance.labels.remediation_controls',
    'dashboards.corporategovernance.labels.aura_briefing',
  ];

  @override
  Widget build(BuildContext context) =>
      const CorporateGovernanceDashboardScreen();
}
