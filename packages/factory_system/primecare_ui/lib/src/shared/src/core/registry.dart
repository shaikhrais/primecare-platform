import 'models.dart';

enum UserRole {
  admin,
  ceo,
  cfo,
  coo,
  cto,
  clinicalDirector,
  financeDirector,
  patient,
  support,
  intakeCoordinator,
  complianceManager,
  marketingManager,
  franchiseOwner,
}

class DashboardRegistry {
  static final Map<UserRole, List<DashboardWidgetConfig>> inventory = {
    UserRole.admin: const [
      DashboardWidgetConfig(id: 'system_health', label: 'System Health', type: WidgetType.metricCard),
      DashboardWidgetConfig(id: 'active_users', label: 'Active Users', type: WidgetType.metricCard),
    ],
    UserRole.ceo: const [
      DashboardWidgetConfig(id: 'strategic_growth', label: 'Strategic Growth', type: WidgetType.chart),
      DashboardWidgetConfig(id: 'revenue_growth', label: 'Revenue Growth', type: WidgetType.metricCard),
      DashboardWidgetConfig(id: 'operational_efficiency', label: 'Operational Efficiency', type: WidgetType.dataTable),
      DashboardWidgetConfig(id: 'market_expansion', label: 'Market Expansion', type: WidgetType.list),
    ],
    UserRole.cfo: const [
      DashboardWidgetConfig(id: 'ebitda_ttm', label: 'EBITDA (TTM)', type: WidgetType.metricCard),
      DashboardWidgetConfig(id: 'cash_on_hand', label: 'Cash on Hand', type: WidgetType.metricCard),
      DashboardWidgetConfig(id: 'net_margin', label: 'Net Margin', type: WidgetType.chart),
      DashboardWidgetConfig(id: 'operational_burn', label: 'Operational Burn', type: WidgetType.dataTable),
      DashboardWidgetConfig(id: 'tax_optimization', label: 'Tax Optimization Opportunity', type: WidgetType.list),
      DashboardWidgetConfig(id: 'ar_alert', label: 'Accounts Receivable Alert', type: WidgetType.metricCard),
      DashboardWidgetConfig(id: 'capital_efficiency', label: 'Capital Allocation Efficiency', type: WidgetType.chart),
    ],
    UserRole.coo: const [
      DashboardWidgetConfig(id: 'operational_insights', label: 'Operational Insights Unified', type: WidgetType.chart),
      DashboardWidgetConfig(id: 'burn_rate_analysis', label: 'Burn Rate Analysis', type: WidgetType.dataTable),
      DashboardWidgetConfig(id: 'operational_volume', label: 'Operational Volume', type: WidgetType.metricCard),
    ],
    UserRole.cto: const [
      DashboardWidgetConfig(id: 'global_uptime', label: 'Global Uptime', type: WidgetType.metricCard),
      DashboardWidgetConfig(id: 'api_latency', label: 'Avg API Latency', type: WidgetType.chart),
      DashboardWidgetConfig(id: 'error_rate', label: 'Error Rate', type: WidgetType.metricCard),
      DashboardWidgetConfig(id: 'security_posture', label: 'Security Posture: Critical', type: WidgetType.list),
      DashboardWidgetConfig(id: 'devops_velocity', label: 'DevOps Velocity', type: WidgetType.chart),
    ],
    UserRole.clinicalDirector: const [
      DashboardWidgetConfig(id: 'staffing_matrix', label: 'Staffing Coverage Matrix', type: WidgetType.dataTable),
      DashboardWidgetConfig(id: 'compliance_log', label: 'Protocol Compliance Log', type: WidgetType.list),
      DashboardWidgetConfig(id: 'incident_trends', label: 'Incident Trends 30', type: WidgetType.chart),
    ],
    UserRole.financeDirector: const [
      DashboardWidgetConfig(id: 'cash_flow', label: 'Cash Flow', type: WidgetType.chart),
      DashboardWidgetConfig(id: 'ledger_command', label: 'Ledger Command', type: WidgetType.dataTable),
    ],
    UserRole.marketingManager: const [
      DashboardWidgetConfig(id: 'campaign_roi_peak', label: 'Campaign ROI Peak', type: WidgetType.chart),
      DashboardWidgetConfig(id: 'cac_volatility', label: 'CAC Volatility Detected', type: WidgetType.list),
    ],
    UserRole.franchiseOwner: const [
      DashboardWidgetConfig(id: 'business_overview', label: 'Business Overview', type: WidgetType.metricCard),
      DashboardWidgetConfig(id: 'financial_performance', label: 'Financial Performance', type: WidgetType.chart),
      DashboardWidgetConfig(id: 'compliance_status', label: 'Compliance Status', type: WidgetType.dataTable),
    ],
    UserRole.patient: const [
      DashboardWidgetConfig(id: 'upcoming_appointments', label: 'Upcoming Appointments', type: WidgetType.list),
      DashboardWidgetConfig(id: 'care_plan', label: 'My Care Plan', type: WidgetType.metricCard),
    ],
    UserRole.support: const [
      DashboardWidgetConfig(id: 'open_tickets', label: 'Open Tickets', type: WidgetType.metricCard),
      DashboardWidgetConfig(id: 'avg_response_time', label: 'Avg Response Time', type: WidgetType.metricCard),
      DashboardWidgetConfig(id: 'satisfaction_score', label: 'Satisfaction Score', type: WidgetType.chart),
      DashboardWidgetConfig(id: 'sla_breach_risk', label: 'SLA Breach Risk', type: WidgetType.list),
    ],
    UserRole.intakeCoordinator: const [
      DashboardWidgetConfig(id: 'new_leads', label: 'New Patient Leads', type: WidgetType.dataTable),
      DashboardWidgetConfig(id: 'pending_verifications', label: 'Pending Verifications', type: WidgetType.list),
    ],
    UserRole.complianceManager: const [
      DashboardWidgetConfig(id: 'compliance_status', label: 'Recent Audits', type: WidgetType.dataTable),
      DashboardWidgetConfig(id: 'incident_reports', label: 'Incident Reports', type: WidgetType.list),
    ],
  };
}
