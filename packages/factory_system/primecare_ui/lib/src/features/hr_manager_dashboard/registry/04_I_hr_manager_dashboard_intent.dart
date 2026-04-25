// Layer: 04_REGISTRY_INTENT
import 'package:primecare_ui/primecare_ui.dart';

class HrManagerDashboardIntent extends PrimeCareScreen {
  HrManagerDashboardIntent()
    : super(
        name: 'hr_manager_dashboard',
        title: 'Human Capital Command',
        subtitle: 'Governance, Recruitment Velocity & Talent Intelligence',
        route: FranchiseRoutes.hrHiringDashboard,
        requiredRole: PlatformRole.hrHiring,
        provider: hrMetricsProvider,
        componentLabels: [
          'Aura HUD',
          'Staffing Velocity Matrix',
          'Hiring Funnel Grid',
          'Human Capital Intelligence',
          'Compliance Audit Node',
          'HR Action Hub',
        ],
        structuralPlan: '''
[PrimeCareScaffold]
  - [AuraDashboardHud]: Global Human Capital Health & Governance
  - [Command Row]: Post Job, Leave Approval, Payroll Sync, Compliance Audit
  - [ResponsiveKpiGrid]: Active Postings, Offer Accept Rate, Time to Fill
  - [Staffing Velocity Matrix]: Visual trend of hiring vs turnover across departments
  - [Human Capital Intelligence]: AI insights on recruitment bottlenecks and retention risks
  - [Hiring Funnel Grid]: Granular stage tracking for active recruitment pipelines
  - [HR Action Hub]: Rapid triggers for employee life-cycle management and payroll
''',
      );

  @override
  Widget build(BuildContext context) => const HrManagerDashboardScreen();
}
