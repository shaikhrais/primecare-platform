import 'models.dart';

enum UserRole {
  ceo,
  cfo,
  clinicalDirector,
  patient,
  support,
  intakeCoordinator,
  complianceManager
}

class DashboardRegistry {
  static final Map<UserRole, List<DashboardWidgetConfig>> inventory = {
    UserRole.ceo: const [
      DashboardWidgetConfig(id: 'revenue_chart', label: 'Global Revenue', type: WidgetType.chart),
      DashboardWidgetConfig(id: 'active_patients', label: 'Active Patients', type: WidgetType.metricCard),
    ],
    UserRole.cfo: const [
      DashboardWidgetConfig(id: 'revenue_chart', label: 'Global Revenue', type: WidgetType.chart),
      DashboardWidgetConfig(id: 'expense_report', label: 'Q3 Expenses', type: WidgetType.dataTable),
    ],
    UserRole.clinicalDirector: const [
      DashboardWidgetConfig(id: 'infection_control', label: 'Infection Control Alerts', type: WidgetType.metricCard),
      DashboardWidgetConfig(id: 'patient_admissions', label: 'Recent Admissions', type: WidgetType.list),
    ],
    UserRole.patient: const [
      DashboardWidgetConfig(id: 'upcoming_appointments', label: 'Upcoming Appointments', type: WidgetType.list),
      DashboardWidgetConfig(id: 'care_plan', label: 'My Care Plan', type: WidgetType.metricCard),
    ],
    UserRole.intakeCoordinator: const [
      DashboardWidgetConfig(id: 'new_leads', label: 'New Patient Leads', type: WidgetType.dataTable),
      DashboardWidgetConfig(id: 'pending_verifications', label: 'Pending Verifications', type: WidgetType.list),
    ],
    UserRole.complianceManager: const [
      DashboardWidgetConfig(id: 'audit_status', label: 'Recent Audits', type: WidgetType.dataTable),
      DashboardWidgetConfig(id: 'incident_reports', label: 'Incident Reports', type: WidgetType.list),
    ],
  };
}
