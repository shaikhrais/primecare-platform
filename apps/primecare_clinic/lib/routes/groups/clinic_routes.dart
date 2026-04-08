import 'package:go_router/go_router.dart';
import '../app_routes.dart';
import 'package:primecare_ui/src/components/generic_feature_screen.dart';

import '../../offices/clinic/roles/rn/rn_dashboard.dart' as rn_dash;
import '../../offices/clinic/roles/rpn/rpn_dashboard.dart' as rpn_dash;
import '../../offices/clinic/roles/rmt/rmt_dashboard.dart' as rmt_dash;
import '../../offices/clinic/roles/psw/psw_dashboard.dart' as psw_dash;
import '../../offices/clinic/roles/psw/todays_shifts.dart' as psw_todays_shifts;
import '../../offices/clinic/roles/psw/assigned_clients.dart'
    as psw_assigned_clients;
import '../../offices/clinic/roles/psw/care_tasks.dart' as psw_care_tasks;
import '../../offices/clinic/roles/psw/adl_tracking.dart' as psw_adl_tracking;
import '../../offices/clinic/roles/psw/daily_logs.dart' as psw_daily_logs;
import '../../offices/clinic/roles/psw/check_in_out.dart' as psw_check_in_out;
import '../../offices/clinic/roles/psw/client_updates.dart'
    as psw_client_updates;
import '../../offices/clinic/roles/psw/incident_reports.dart'
    as psw_incident_reports;
import '../../offices/clinic/roles/psw/completed_visits.dart'
    as psw_completed_visits;
import '../../offices/clinic/roles/psw/documents.dart' as psw_documents;
import '../../offices/clinic/roles/psw/settings.dart' as psw_settings;
import '../../offices/clinic/roles/head_of_business_development/lead_pipeline.dart'
    as head_of_business_development_lead_pipeline;
import '../../offices/clinic/roles/head_of_business_development/franchise_pipeline.dart'
    as head_of_business_development_franchise_pipeline;
import '../../offices/clinic/roles/head_of_business_development/territory_map.dart'
    as head_of_business_development_territory_map;
import '../../offices/clinic/roles/head_of_business_development/partnerships.dart'
    as head_of_business_development_partnerships;
import '../../offices/clinic/roles/head_of_business_development/opportunities.dart'
    as head_of_business_development_opportunities;
import '../../offices/clinic/roles/head_of_business_development/sales_performance.dart'
    as head_of_business_development_sales_performance;
import '../../offices/clinic/roles/head_of_business_development/expansion_forecast.dart'
    as head_of_business_development_expansion_forecast;
import '../../offices/clinic/roles/head_of_business_development/reports.dart'
    as head_of_business_development_reports;
import '../../offices/clinic/roles/rn/todays_schedule.dart'
    as rn_todays_schedule;
import '../../offices/clinic/roles/rn/assigned_clients.dart'
    as rn_assigned_clients;
import '../../offices/clinic/roles/rn/nursing_notes.dart' as rn_nursing_notes;
import '../../offices/clinic/roles/rn/care_plans.dart' as rn_care_plans;
import '../../offices/clinic/roles/rn/medication_notes.dart'
    as rn_medication_notes;
import '../../offices/clinic/roles/rn/vitals.dart' as rn_vitals;
import '../../offices/clinic/roles/rn/incident_reports.dart'
    as rn_incident_reports;
import '../../offices/clinic/roles/rn/progress_updates.dart'
    as rn_progress_updates;
import '../../offices/clinic/roles/rn/client_history.dart' as rn_client_history;
import '../../offices/clinic/roles/rpn/todays_schedule.dart'
    as rpn_todays_schedule;
import '../../offices/clinic/roles/rpn/assigned_clients.dart'
    as rpn_assigned_clients;
import '../../offices/clinic/roles/rpn/nursing_notes.dart' as rpn_nursing_notes;
import '../../offices/clinic/roles/rpn/care_updates.dart' as rpn_care_updates;
import '../../offices/clinic/roles/rpn/vitals.dart' as rpn_vitals;
import '../../offices/clinic/roles/rpn/medication_support.dart'
    as rpn_medication_support;
import '../../offices/clinic/roles/rpn/client_history.dart'
    as rpn_client_history;
import '../../offices/clinic/roles/rpn/incident_reports.dart'
    as rpn_incident_reports;
import '../../offices/clinic/roles/rmt/todays_schedule.dart'
    as rmt_todays_schedule;
import '../../offices/clinic/roles/rmt/clients.dart' as rmt_clients;
import '../../offices/clinic/roles/rmt/assessment.dart' as rmt_assessment;
import '../../offices/clinic/roles/rmt/soap_notes.dart' as rmt_soap_notes;
import '../../offices/clinic/roles/rmt/treatment_plans.dart'
    as rmt_treatment_plans;
import '../../offices/clinic/roles/rmt/homecare.dart' as rmt_homecare;
import '../../offices/clinic/roles/rmt/session_history.dart'
    as rmt_session_history;
import '../../offices/clinic/roles/rmt/body_chart.dart' as rmt_body_chart;
import '../../offices/clinic/roles/rmt/intake_forms.dart' as rmt_intake_forms;
import '../../offices/clinic/roles/rmt/invoices.dart' as rmt_invoices;
import '../../offices/clinic/roles/physio/physio_dashboard.dart' as physio_dash;
import '../../offices/clinic/roles/chiro/chiro_dashboard.dart' as chiro_dash;
import '../../offices/clinic/roles/occupational_therapist/ot_dashboard.dart'
    as ot_dash;
import '../../offices/clinic/roles/speech_pathologist/slp_dashboard.dart'
    as slp_dash;

final List<RouteBase> clinicRoutes = [
  GoRoute(
    path: AppRoutes.rnDashboard,
    builder: (context, state) => const rn_dash.RnDashboard(),
  ),
  GoRoute(
    path: AppRoutes.rpnDashboard,
    builder: (context, state) => const rpn_dash.RpnDashboard(),
  ),
  GoRoute(
    path: AppRoutes.rmtDashboard,
    builder: (context, state) => const rmt_dash.RmtDashboard(),
  ),
  GoRoute(
    path: AppRoutes.pswDashboard,
    builder: (context, state) => const psw_dash.PswDashboard(),
  ),
  GoRoute(
    path: AppRoutes.pswTodaysShifts,
    builder: (context, state) =>
        const psw_todays_shifts.PswTodaysShiftsScreen(),
  ),
  GoRoute(
    path: AppRoutes.pswAssignedClients,
    builder: (context, state) =>
        const psw_assigned_clients.PswAssignedClientsScreen(),
  ),
  GoRoute(
    path: AppRoutes.pswCareTasks,
    builder: (context, state) => const psw_care_tasks.PswCareTasksScreen(),
  ),
  GoRoute(
    path: AppRoutes.pswAdlTracking,
    builder: (context, state) => const psw_adl_tracking.PswAdlTrackingScreen(),
  ),
  GoRoute(
    path: AppRoutes.pswDailyLogs,
    builder: (context, state) => const psw_daily_logs.PswDailyLogsScreen(),
  ),
  GoRoute(
    path: AppRoutes.pswCheckInOut,
    builder: (context, state) => const psw_check_in_out.PswCheckInOutScreen(),
  ),
  GoRoute(
    path: AppRoutes.pswClientUpdates,
    builder: (context, state) =>
        const psw_client_updates.PswClientUpdatesScreen(),
  ),
  GoRoute(
    path: AppRoutes.pswIncidentReports,
    builder: (context, state) =>
        const psw_incident_reports.PswIncidentReportsScreen(),
  ),
  GoRoute(
    path: AppRoutes.pswCompletedVisits,
    builder: (context, state) =>
        const psw_completed_visits.PswCompletedVisitsScreen(),
  ),
  GoRoute(
    path: AppRoutes.pswDocuments,
    builder: (context, state) => const psw_documents.PswDocumentsScreen(),
  ),
  GoRoute(
    path: AppRoutes.pswSettings,
    builder: (context, state) => const psw_settings.PswSettingsScreen(),
  ),
  GoRoute(
    path: AppRoutes.headOfBusinessDevelopmentLeadPipeline,
    builder: (context, state) =>
        const head_of_business_development_lead_pipeline.LeadPipelineScreen(),
  ),
  GoRoute(
    path: AppRoutes.headOfBusinessDevelopmentTerritoryMap,
    builder: (context, state) =>
        const head_of_business_development_territory_map.TerritoryMapScreen(),
  ),
  GoRoute(
    path: AppRoutes.headOfBusinessDevelopmentPartnerships,
    builder: (context, state) =>
        const head_of_business_development_partnerships.PartnershipsScreen(),
  ),
  GoRoute(
    path: AppRoutes.headOfBusinessDevelopmentOpportunities,
    builder: (context, state) =>
        const head_of_business_development_opportunities.OpportunitiesScreen(),
  ),
  GoRoute(
    path: AppRoutes.headOfBusinessDevelopmentSalesPerformance,
    builder: (context, state) =>
        const head_of_business_development_sales_performance.SalesPerformanceScreen(),
  ),
  GoRoute(
    path: AppRoutes.headOfBusinessDevelopmentExpansionForecast,
    builder: (context, state) =>
        const head_of_business_development_expansion_forecast.ExpansionForecastScreen(),
  ),
  GoRoute(
    path: AppRoutes.rnTodaysSchedule,
    builder: (context, state) =>
        const rn_todays_schedule.TodaysScheduleScreen(),
  ),
  GoRoute(
    path: AppRoutes.rnAssignedClients,
    builder: (context, state) =>
        const rn_assigned_clients.AssignedClientsScreen(),
  ),
  GoRoute(
    path: AppRoutes.rnNursingNotes,
    builder: (context, state) => const rn_nursing_notes.NursingNotesScreen(),
  ),
  GoRoute(
    path: AppRoutes.rnCarePlans,
    builder: (context, state) => const rn_care_plans.CarePlansScreen(),
  ),
  GoRoute(
    path: AppRoutes.rnMedicationNotes,
    builder: (context, state) =>
        const rn_medication_notes.MedicationAdministrationScreen(),
  ),
  GoRoute(
    path: AppRoutes.rnVitals,
    builder: (context, state) => const rn_vitals.VitalsScreen(),
  ),
  GoRoute(
    path: AppRoutes.rnIncidentReports,
    builder: (context, state) =>
        const rn_incident_reports.IncidentReportsScreen(),
  ),
  GoRoute(
    path: AppRoutes.rnProgressUpdates,
    builder: (context, state) =>
        const rn_progress_updates.ProgressUpdatesScreen(),
  ),
  GoRoute(
    path: AppRoutes.rnClientHistory,
    builder: (context, state) => const rn_client_history.ClientHistoryScreen(),
  ),
  GoRoute(
    path: AppRoutes.rpnTodaysSchedule,
    builder: (context, state) =>
        const rpn_todays_schedule.RpnTodaysScheduleScreen(),
  ),
  GoRoute(
    path: AppRoutes.rpnAssignedClients,
    builder: (context, state) =>
        const rpn_assigned_clients.RpnAssignedClientsScreen(),
  ),
  GoRoute(
    path: AppRoutes.rpnNursingNotes,
    builder: (context, state) =>
        const rpn_nursing_notes.RpnnursingNotesScreen(),
  ),
  GoRoute(
    path: AppRoutes.rpnCareUpdates,
    builder: (context, state) => const rpn_care_updates.RpnCareUpdatesScreen(),
  ),
  GoRoute(
    path: AppRoutes.rpnVitals,
    builder: (context, state) => const rpn_vitals.RpnVitalsScreen(),
  ),
  GoRoute(
    path: AppRoutes.rpnMedicationSupport,
    builder: (context, state) =>
        const rpn_medication_support.RpnMedicationSupportScreen(),
  ),
  GoRoute(
    path: AppRoutes.rpnClientHistory,
    builder: (context, state) =>
        const rpn_client_history.RpnClientHistoryScreen(),
  ),
  GoRoute(
    path: AppRoutes.rpnIncidentReports,
    builder: (context, state) =>
        const rpn_incident_reports.RpnIncidentReportsScreen(),
  ),
  GoRoute(
    path: AppRoutes.rmtTodaysSchedule,
    builder: (context, state) =>
        const rmt_todays_schedule.RmtTodaysScheduleScreen(),
  ),
  GoRoute(
    path: AppRoutes.rmtClients,
    builder: (context, state) => const rmt_clients.RmtClientsScreen(),
  ),
  GoRoute(
    path: AppRoutes.rmtAssessment,
    builder: (context, state) => const rmt_assessment.RmtAssessmentScreen(),
  ),
  GoRoute(
    path: AppRoutes.rmtSoapNotes,
    builder: (context, state) => const rmt_soap_notes.RmtSoapNotesScreen(),
  ),
  GoRoute(
    path: AppRoutes.rmtTreatmentPlans,
    builder: (context, state) =>
        const rmt_treatment_plans.RmtTreatmentPlansScreen(),
  ),
  GoRoute(
    path: AppRoutes.rmtHomecare,
    builder: (context, state) => const rmt_homecare.RmtHomecareScreen(),
  ),
  GoRoute(
    path: AppRoutes.rmtSessionHistory,
    builder: (context, state) =>
        const rmt_session_history.RmtSessionHistoryScreen(),
  ),
  GoRoute(
    path: AppRoutes.rmtBodyChart,
    builder: (context, state) => const rmt_body_chart.RmtBodyChartScreen(),
  ),
  GoRoute(
    path: AppRoutes.rmtIntakeForms,
    builder: (context, state) => const rmt_intake_forms.RmtIntakeFormsScreen(),
  ),
  GoRoute(
    path: AppRoutes.rmtInvoices,
    builder: (context, state) => const rmt_invoices.RmtInvoicesScreen(),
  ),
  GoRoute(
    path: AppRoutes.physioDashboard,
    builder: (context, state) => const physio_dash.PhysioDashboard(),
  ),
  GoRoute(
    path: AppRoutes.chiroDashboard,
    builder: (context, state) => const chiro_dash.ChiroDashboard(),
  ),
  GoRoute(
    path: AppRoutes.occupationalTherapistDashboard,
    builder: (context, state) => const ot_dash.OtDashboard(),
  ),
  GoRoute(
    path: AppRoutes.speechPathologistDashboard,
    builder: (context, state) => const slp_dash.SlpDashboard(),
  ),
];
