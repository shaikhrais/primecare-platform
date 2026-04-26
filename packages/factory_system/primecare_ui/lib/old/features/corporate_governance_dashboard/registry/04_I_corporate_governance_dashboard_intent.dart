import 'package:primecare_ui/primecare_ui.dart';

/// The institutional intent for the Governance Compliance Monitor.
/// This intent overrides the default build logic to render the high-fidelity
/// audit dashboard directly, bypassing the generic assembly engine.
class CorporateGovernanceDashboardIntent extends PrimeCareScreen {
  CorporateGovernanceDashboardIntent()
    : super(
        name: 'corporate_governance',
        title: LocaleKeys.dashboards_common_labels_corporate_governance_hud
            .tr(),
        subtitle: LocaleKeys
            .dashboards_common_labels_institutional_integrity_and_architectural_compliance_audit
            .tr(),
        requiredRole: PlatformRole.admin,
        route: InfrastructureRoutes.governanceMonitor,
        provider: corporateGovernanceDashboardAdapterProvider,
      );

  @override
  String get structuralPlan =>
      'Institutional Integrity Stack: Primary audit metrics in hero, detailed violation logs in list view, and self-healing remediation actions in footer.';

  @override
  List<String> get componentLabels => [
    'dashboards.corporategovernance.labels.dashboards_corporategovernance_labels_compliance_hero',
    'dashboards.corporategovernance.labels.dashboards_corporategovernance_labels_violation_logs',
    'dashboards.corporategovernance.labels.dashboards_corporategovernance_labels_remediation_controls',
    'dashboards.corporategovernance.labels.dashboards_corporategovernance_labels_aura_briefing',
  ];

  @override
  Widget build(BuildContext context) =>
      const CorporateGovernanceDashboardScreen();
}
