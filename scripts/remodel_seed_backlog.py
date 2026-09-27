# Scripts - Category: remodel | Purpose: Set up screen_seed_backlog table and v_role_screen_coverage view, perform analysis on weak roles, and seed suggested workflow screens.
import os
import sqlite3
from datetime import datetime

DB_PATH = os.path.join(".agents", "governance", "governance.db")

# Define screen sets for clinical, corporate, franchise, and client/family roles
ROLE_SCREEN_REQUIREMENTS = {
    # 1. Clinic roles
    "psw": [
        ("psw_command_center", "PswCommandCenterScreen", "dashboard", "High-fidelity CommandCenter overview of shifts, vitals, and emergency alerts."),
        ("psw_my_shifts", "PswMyShiftsScreen", "queue", "List of assigned and open caregiver shifts."),
        ("psw_client_profile", "PswClientProfileScreen", "detail", "Detailed profile and background of care clients."),
        ("psw_visit_notes", "PswVisitNotesScreen", "form", "Data entry form for visit logs and shift notes."),
        ("psw_vitals_log", "PswVitalsLogScreen", "form", "Entry log capturing client heart rate, temperature, and blood pressure."),
        ("psw_incident_report", "PswIncidentReportScreen", "form", "Critical form to report shift safety incidents."),
        ("psw_care_plan", "PswCarePlanScreen", "detail", "Review screen for client physician care instructions."),
        ("psw_messages", "PswMessagesScreen", "messages", "Secure client-caregiver messaging portal."),
        ("psw_documents", "PswDocumentsScreen", "documents", "Platform for uploading client consent files.")
    ],
    "rn": [
        ("rn_command_center", "RnCommandCenterScreen", "dashboard", "Big clinical command overview showing patients and alerts."),
        ("rn_patient_charting", "RnPatientChartingScreen", "queue", "Charting queue to review clinical entries."),
        ("rn_medications", "RnMedicationsScreen", "detail", "Patient pharmaceutical prescription detail view."),
        ("rn_vitals", "RnVitalsScreen", "form", "Form to record dynamic clinical vital signs."),
        ("rn_care_plan_review", "RnCarePlanReviewScreen", "detail", "Review layout to revise physician care instructions."),
        ("rn_incident_review", "RnIncidentReviewScreen", "detail", "Detailed audit layout for nurse safety logs."),
        ("rn_tasks", "RnTasksScreen", "queue", "Clinical workflow tasks and check logs queue."),
        ("rn_reports", "RnReportsScreen", "reports", "Advanced medical compliance and statistics reports.")
    ],
    "rpn": [
        ("rpn_command_center", "RpnCommandCenterScreen", "dashboard", "Clinical command overview for Registered Practical Nurses."),
        ("rpn_patient_charting", "RpnPatientChartingScreen", "queue", "Charting queue to review clinical entries."),
        ("rpn_medications", "RpnMedicationsScreen", "detail", "Patient pharmaceutical prescription detail view."),
        ("rpn_vitals", "RpnVitalsScreen", "form", "Form to record dynamic clinical vital signs."),
        ("rpn_care_plan_review", "RpnCarePlanReviewScreen", "detail", "Review layout to revise physician care instructions."),
        ("rpn_incident_review", "RpnIncidentReviewScreen", "detail", "Detailed audit layout for nurse safety logs."),
        ("rpn_tasks", "RpnTasksScreen", "queue", "Clinical workflow tasks and check logs queue."),
        ("rpn_reports", "RpnReportsScreen", "reports", "Medical compliance and statistics reports.")
    ],
    "rmt": [
        ("rmt_command_center", "RmtCommandCenterScreen", "dashboard", "Massage therapist operation and calendar center."),
        ("rmt_appointments", "RmtAppointmentsScreen", "queue", "Appointments booking queue for massage therapy."),
        ("rmt_client_intake", "RmtClientIntakeScreen", "form", "Intake form capturing muscle history and pain points."),
        ("rmt_assessment", "RmtAssessmentScreen", "detail", "Review layout analyzing physical posture checks."),
        ("rmt_treatment_notes", "RmtTreatmentNotesScreen", "form", "Session records and SOAP treatment logs entry form."),
        ("rmt_exercise_plan", "RmtExercisePlanScreen", "detail", "Post-treatment rehabilitation homework guide."),
        ("rmt_billing_link", "RmtBillingLinkScreen", "form", "Direct invoice creation and ledger tracking form."),
        ("rmt_reports", "RmtReportsScreen", "reports", "Practice performance and revenue reports.")
    ],
    "physiotherapist": [
        ("physiotherapist_command_center", "PhysiotherapistCommandCenterScreen", "dashboard", "Physical therapy operations command center."),
        ("physiotherapist_appointments", "PhysiotherapistAppointmentsScreen", "queue", "Active patient appointments and check-in queue."),
        ("physiotherapist_client_intake", "PhysiotherapistClientIntakeScreen", "form", "Intake form for injury history and motion limits."),
        ("physiotherapist_assessment", "PhysiotherapistAssessmentScreen", "detail", "Motion metrics and posture assessment details."),
        ("physiotherapist_treatment_notes", "PhysiotherapistTreatmentNotesScreen", "form", "SOAP notes logging therapy execution."),
        ("physiotherapist_exercise_plan", "PhysiotherapistExercisePlanScreen", "detail", "Rehabilitation exercises and stretching guide."),
        ("physiotherapist_billing_link", "PhysiotherapistBillingLinkScreen", "form", "Direct payment link creation form."),
        ("physiotherapist_reports", "PhysiotherapistReportsScreen", "reports", "Patient recovery rate and session analytics.")
    ],
    "chiropractor": [
        ("chiropractor_command_center", "ChiropractorCommandCenterScreen", "dashboard", "Chiropractic adjustments command center."),
        ("chiropractor_appointments", "ChiropractorAppointmentsScreen", "queue", "Active patient appointments and check-in queue."),
        ("chiropractor_client_intake", "ChiropractorClientIntakeScreen", "form", "Intake form for spinal history and pain points."),
        ("chiropractor_assessment", "ChiropractorAssessmentScreen", "detail", "Spinal alignment metrics and posture details."),
        ("chiropractor_treatment_notes", "ChiropractorTreatmentNotesScreen", "form", "SOAP notes logging adjustments."),
        ("chiropractor_exercise_plan", "ChiropractorExercisePlanScreen", "detail", "Post-adjustment stretching and posture guide."),
        ("chiropractor_billing_link", "ChiropractorBillingLinkScreen", "form", "Direct payment link creation form."),
        ("chiropractor_reports", "ChiropractorReportsScreen", "reports", "Patient recovery rate and session analytics.")
    ],
    "intake_coordinator": [
        ("intake_coordinator_referrals", "IntakeCoordinatorReferralsScreen", "queue", "Clinical referral queue capturing agency entries."),
        ("intake_coordinator_new_client_intake", "IntakeCoordinatorNewClientIntakeScreen", "form", "Form to register new client and establish accounts."),
        ("intake_coordinator_assessment_queue", "IntakeCoordinatorAssessmentQueueScreen", "queue", "Pending clinical assessment schedules queue."),
        ("intake_coordinator_booking", "IntakeCoordinatorBookingScreen", "form", "Form to bind caregivers to first assessment shifts."),
        ("intake_coordinator_documents", "IntakeCoordinatorDocumentsScreen", "documents", "Client medical history files organizer."),
        ("intake_coordinator_follow_up", "IntakeCoordinatorFollowUpScreen", "form", "Form to log intake check-ins and satisfaction.")
    ],
    "clinical_director": [
        ("clinical_director_staff_quality", "ClinicalDirectorStaffQualityScreen", "queue", "Queue to review nurse performance audit scores."),
        ("clinical_director_incident_review", "ClinicalDirectorIncidentReviewScreen", "detail", "Detail layout to analyze high-priority safety incidents."),
        ("clinical_director_compliance", "ClinicalDirectorComplianceScreen", "reports", "Interactive dashboard auditing medical regulation compliance."),
        ("clinical_director_reports", "ClinicalDirectorReportsScreen", "reports", "Advanced statistics on medication discrepancies."),
        ("clinical_director_approvals", "ClinicalDirectorApprovalsScreen", "form", "Clinical care plan revision authorization form."),
        ("clinical_director_performance", "ClinicalDirectorPerformanceScreen", "detail", "Review card for clinical service quality scores.")
    ],

    # 2. Corporate roles
    "ceo": [
        ("ceo_command_center", "CeoCommandCenterScreen", "dashboard", "Big 4K enterprise overview of branch statistics, growth, and risks."),
        ("ceo_approvals", "CeoApprovalsScreen", "queue", "High-level franchise agreement and budget approvals queue."),
        ("ceo_risks", "CeoRisksScreen", "detail", "Detail review card for corporate legal liability risks."),
        ("ceo_revenue", "CeoRevenueScreen", "reports", "Interactive enterprise revenue dashboard."),
        ("ceo_growth", "CeoGrowthScreen", "reports", "New branch mapping and market share growth charts."),
        ("ceo_branch_map", "CeoBranchMapScreen", "detail", "Geospatial coordinate visualizer showing active branches."),
        ("ceo_reports", "CeoReportsScreen", "reports", "Annual corporate productivity and compliance reports.")
    ],
    "coo": [
        ("coo_command_center", "CooCommandCenterScreen", "dashboard", "Big 4K operations command center for staffing, schedule health, and comparison."),
        ("coo_operations_overview", "CooOperationsOverviewScreen", "dashboard", "Overview tracking overall platform operation metrics."),
        ("coo_staffing", "CooStaffingScreen", "queue", "Queue to review overall caregiver recruitment counts."),
        ("coo_scheduling_health", "CooSchedulingHealthScreen", "reports", "Schedule utilization efficiency charts."),
        ("coo_workflow_issues", "CooWorkflowIssuesScreen", "detail", "Detail log capturing branch bottlenecks."),
        ("coo_branch_comparison", "CooBranchComparisonScreen", "reports", "Side-by-side performance indicators comparison.")
    ],
    "cfo": [
        ("cfo_revenue", "CfoRevenueScreen", "reports", "Double-entry transaction billing revenue dashboard."),
        ("cfo_expenses", "CfoExpensesScreen", "reports", "Expense ledger tracking branch payouts."),
        ("cfo_payroll", "CfoPayrollScreen", "queue", "Caregiver monthly payroll processing queue."),
        ("cfo_invoices", "CfoInvoicesScreen", "queue", "Client accounts receivable invoices queue."),
        ("cfo_tax", "CfoTaxScreen", "reports", "HST/GST sales tax remittance dashboard."),
        ("cfo_profitability", "CfoProfitabilityScreen", "reports", "Branch-wise net profitability analytics."),
        ("cfo_cashflow", "CfoCashflowScreen", "reports", "Cash flow forecast charts.")
    ],
    "cto": [
        ("cto_api_monitoring", "CtoApiMonitoringScreen", "queue", "Live REST API endpoint response monitoring queue."),
        ("cto_deployment", "CtoDeploymentScreen", "queue", "Cloudflare deployment pipeline triggers queue."),
        ("cto_system_health", "CtoSystemHealthScreen", "reports", "Database CPU and edge memory latency logs."),
        ("cto_access_control", "CtoAccessControlScreen", "detail", "Platform role-based security settings console."),
        ("cto_audit_logs", "CtoAuditLogsScreen", "reports", "Programmatic user session audit logger."),
        ("cto_release_management", "CtoReleaseManagementScreen", "queue", "Monorepo version tags and feature gates manager.")
    ],
    "hr_director": [
        ("hr_director_hiring_pipeline", "HrDirectorHiringPipelineScreen", "queue", "Corporate caregiver applicant pipeline queue."),
        ("hr_director_staff_files", "HrDirectorStaffFilesScreen", "detail", "Employee background checks detail cards."),
        ("hr_director_training", "HrDirectorTrainingScreen", "detail", "Employee compliance training review board."),
        ("hr_director_credential_expiry", "HrDirectorCredentialExpiryScreen", "queue", "Upcoming credential and license expirations alert queue."),
        ("hr_director_onboarding", "HrDirectorOnboardingScreen", "form", "New hire orientation registration form.")
    ],
    "compliance_manager": [
        ("compliance_manager_audits", "ComplianceManagerAuditsScreen", "queue", "Regulatory compliance audits scheduling queue."),
        ("compliance_manager_incidents", "ComplianceManagerIncidentsScreen", "detail", "Detail layout reviewing safety violations."),
        ("compliance_manager_corrective_actions", "ComplianceManagerCorrectiveActionsScreen", "form", "Form to issue compliance remediation alerts."),
        ("compliance_manager_policies", "ComplianceManagerPoliciesScreen", "detail", "Digital directory holding platform corporate bylaws."),
        ("compliance_manager_risk_register", "ComplianceManagerRiskRegisterScreen", "reports", "Interactive branch hazard risk reports.")
    ],

    # 3. Franchise roles
    "franchise_owner": [
        ("franchise_owner_command_center", "FranchiseOwnerCommandCenterScreen", "dashboard", "Big 4K command center showing local operations, finance, and compliance."),
        ("franchise_owner_branch_overview", "FranchiseOwnerBranchOverviewScreen", "dashboard", "Overview tracking overall branch-specific analytics."),
        ("franchise_owner_staff", "FranchiseOwnerStaffScreen", "queue", "Staffing shift roster review queue."),
        ("franchise_owner_clients", "FranchiseOwnerClientsScreen", "queue", "Active client list and outstanding dues queue."),
        ("franchise_owner_appointments", "FranchiseOwnerAppointmentsScreen", "queue", "Booking schedule and availability queue."),
        ("franchise_owner_finance_snapshot", "FranchiseOwnerFinanceSnapshotScreen", "reports", "Net profit and branch expense charts."),
        ("franchise_owner_compliance", "FranchiseOwnerComplianceScreen", "reports", "License audits and staff training status board."),
        ("franchise_owner_reports", "FranchiseOwnerReportsScreen", "reports", "Franchise profitability and metrics reports.")
    ],
    "operations_manager": [
        ("operations_manager_command_center", "OperationsManagerCommandCenterScreen", "dashboard", "Daily operations command center."),
        ("operations_manager_daily_operations", "OperationsManagerDailyOperationsScreen", "dashboard", "Operational dashboard for tracking shift attendance."),
        ("operations_manager_attendance", "OperationsManagerAttendanceScreen", "queue", " Roster tracking caregiver check-ins."),
        ("operations_manager_shifts", "OperationsManagerShiftsScreen", "queue", "Active daily shifts scheduling timeline."),
        ("operations_manager_issues", "OperationsManagerIssuesScreen", "detail", "Incident detail capture card."),
        ("operations_manager_service_quality", "OperationsManagerServiceQualityScreen", "reports", "Client reviews and rating metrics charts.")
    ],
    "scheduler": [
        ("scheduler_command_center", "SchedulerCommandCenterScreen", "dashboard", "Big 4K scheduling dashboard for roster mapping."),
        ("scheduler_calendar", "SchedulerCalendarScreen", "dashboard", "Dynamic interactive shift scheduling calendar board."),
        ("scheduler_booking_requests", "SchedulerBookingRequestsScreen", "queue", "New appointment request scheduling queue."),
        ("scheduler_conflicts", "SchedulerConflictsScreen", "queue", "Roster conflict detection and duplicate assign queue."),
        ("scheduler_open_shifts", "SchedulerOpenShiftsScreen", "queue", "Roster of open shifts awaiting caregiver matches."),
        ("scheduler_provider_availability", "SchedulerProviderAvailabilityScreen", "detail", "Caregiver active availability dashboard.")
    ],
    "billing_admin": [
        ("billing_admin_invoices", "BillingAdminInvoicesScreen", "queue", "Outstanding client accounts receivable queue."),
        ("billing_admin_claims", "BillingAdminClaimsScreen", "queue", "Third-party insurance coverage claims queue."),
        ("billing_admin_payments", "BillingAdminPaymentsScreen", "form", "Manual cash, card, or check payment entry form."),
        ("billing_admin_outstanding_balance", "BillingAdminOutstandingBalanceScreen", "reports", "Outstanding customer balance age reports."),
        ("billing_admin_refunds", "BillingAdminRefundsScreen", "form", "Authorized billing refund ledger adjustments form.")
    ],
    "hr_hiring": [
        ("hr_hiring_applicants", "HrHiringApplicantsScreen", "queue", "Recruitment applicant screening queue."),
        ("hr_hiring_interviews", "HrHiringInterviewsScreen", "queue", "Caregiver interview schedules queue."),
        ("hr_hiring_offers", "HrHiringOffersScreen", "form", "Employment offer details entry form."),
        ("hr_hiring_onboarding", "HrHiringOnboardingScreen", "form", "New hire credential setup registration form."),
        ("hr_hiring_credentials", "HrHiringCredentialsScreen", "detail", "Review card for license and police clearances.")
    ],

    # 4. Client/family roles
    "patient": [
        ("patient_command_center", "PatientCommandCenterScreen", "dashboard", "Big 4K client dashboard showing schedule, billing, and care plan."),
        ("patient_dashboard", "PatientDashboardScreen", "dashboard", "Overview tracking overall patient active portal services."),
        ("patient_appointments", "PatientAppointmentsScreen", "queue", "Active appointments scheduling queue."),
        ("patient_care_plan", "PatientCarePlanScreen", "detail", "Active clinical care plans details list."),
        ("patient_messages", "PatientMessagesScreen", "messages", "Secure nurse-client text messenger."),
        ("patient_documents", "PatientDocumentsScreen", "documents", "Client consent files organizer."),
        ("patient_billing", "PatientBillingScreen", "reports", "Invoice payments history charts."),
        ("patient_profile", "PatientProfileScreen", "detail", "Patient personal profile details card.")
    ],
    "family_member": [
        ("family_member_loved_one_schedule", "FamilyMemberLovedOneScheduleScreen", "queue", " Roster tracking caregiver shifts for loved ones."),
        ("family_member_care_updates", "FamilyMemberCareUpdatesScreen", "detail", "Live log for shift vitals and notes."),
        ("family_member_billing", "FamilyMemberBillingScreen", "reports", "Outstanding balance invoices payment page."),
        ("family_member_emergency_contacts", "FamilyMemberEmergencyContactsScreen", "detail", "Emergency contacts profile cards."),
        ("family_member_messages", "FamilyMemberMessagesScreen", "messages", "Secure messaging link to caregiver/nurse.")
    ],
    "caregiver": [
        ("caregiver_tasks", "CaregiverTasksScreen", "queue", "Shift checklist checklist items queue."),
        ("caregiver_client_profile", "CaregiverClientProfileScreen", "detail", "Detailed profile of care clients."),
        ("caregiver_visit_notes", "CaregiverVisitNotesScreen", "form", "Data entry form for visit logs and shift notes."),
        ("caregiver_schedule", "CaregiverScheduleScreen", "queue", "Shift schedules and roster timeline."),
        ("caregiver_incident_report", "CaregiverIncidentReportScreen", "form", "Critical form to report shift safety incidents.")
    ]
}

def setup_backlog_table():
    if not os.path.exists(DB_PATH):
        print(f"Error: Database not found at {DB_PATH}")
        return

    conn = sqlite3.connect(DB_PATH)
    cursor = conn.cursor()

    # 1. Create screen_seed_backlog table
    cursor.execute("""
    CREATE TABLE IF NOT EXISTS screen_seed_backlog (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      app_id INTEGER NOT NULL,
      role_id INTEGER NOT NULL,
      suggested_screen_code TEXT NOT NULL,
      suggested_screen_name TEXT NOT NULL,
      screen_type TEXT NOT NULL,
      priority TEXT DEFAULT 'high',
      reason TEXT,
      seed_status TEXT DEFAULT 'pending',
      created_at TEXT DEFAULT CURRENT_TIMESTAMP,

      FOREIGN KEY (app_id) REFERENCES apps(id),
      FOREIGN KEY (role_id) REFERENCES roles(id)
    );
    """)

    # 2. Create v_role_screen_coverage view
    cursor.execute("DROP VIEW IF EXISTS v_role_screen_coverage;")
    cursor.execute("""
    CREATE VIEW v_role_screen_coverage AS
    SELECT
      r.id AS role_id,
      r.role_code,
      r.role_name,
      COUNT(DISTINCT rsp.screen_id) AS screen_count,
      SUM(CASE WHEN s.screen_type = 'dashboard' THEN 1 ELSE 0 END) AS dashboard_count,
      CASE
        WHEN COUNT(DISTINCT rsp.screen_id) = 0 THEN 'no_screens'
        WHEN COUNT(DISTINCT rsp.screen_id) = 1 THEN 'only_dashboard'
        WHEN COUNT(DISTINCT rsp.screen_id) < 5 THEN 'weak'
        ELSE 'good'
      END AS coverage_status
    FROM roles r
    LEFT JOIN role_screen_permissions rsp ON rsp.role_id = r.id AND rsp.can_view = 1
    LEFT JOIN screens s ON s.id = rsp.screen_id
    GROUP BY r.id, r.role_code, r.role_name;
    """)
    
    print("Database table 'screen_seed_backlog' and view 'v_role_screen_coverage' initialized successfully.")

    # 3. Query v_role_screen_coverage to identify weak roles
    cursor.execute("SELECT role_id, role_code, role_name, coverage_status FROM v_role_screen_coverage;")
    roles = cursor.fetchall()
    
    weak_roles = [r for r in roles if r[3] in ('no_screens', 'only_dashboard', 'weak')]
    print(f"Discovered {len(weak_roles)} roles requiring workflow screen set seeding.")

    seeded_count = 0
    for role_id, role_code, role_name, coverage_status in weak_roles:
        # Determine base requirements key
        req_key = role_code.lower()
        if req_key not in ROLE_SCREEN_REQUIREMENTS:
            # Fallback checks
            if "coordinator" in req_key:
                req_key = "intake_coordinator"
            elif "director" in req_key and "clinical" in req_key:
                req_key = "clinical_director"
            elif "director" in req_key and "hr" in req_key:
                req_key = "hr_director"
            elif "physio" in req_key:
                req_key = "physiotherapist"
            elif "hiring" in req_key:
                req_key = "hr_hiring"
            elif "manager" in req_key and "operations" in req_key:
                req_key = "operations_manager"
            elif "owner" in req_key:
                req_key = "franchise_owner"
            else:
                continue

        needed_screens = ROLE_SCREEN_REQUIREMENTS[req_key]
        
        # Determine app_id associated with this role code
        cursor.execute("SELECT app_id FROM screens s JOIN role_screen_permissions rsp ON s.id = rsp.screen_id WHERE rsp.role_id = ? LIMIT 1", (role_id,))
        app_match = cursor.fetchone()
        app_id = app_match[0] if app_match else None
        
        # Fallback app_id mapping
        if not app_id:
            if req_key in ["psw", "caregiver"]:
                app_id = 12 # Primecare Support
            elif req_key in ["rn", "rpn", "rmt", "physiotherapist", "chiropractor", "intake_coordinator", "clinical_director"]:
                app_id = 6 # Primecare Clinic
            elif req_key in ["ceo", "coo", "cfo", "cto", "hr_director", "compliance_manager", "operations_manager"]:
                app_id = 7 # Primecare Corporate
            elif req_key in ["franchise_owner", "scheduler", "billing_admin", "hr_hiring"]:
                app_id = 9 # Primecare Franchise
            elif req_key in ["patient", "family_member"]:
                app_id = 5 # Primecare Client
            else:
                app_id = 1 # PrimeCare UI Client (Failsafe)

        # Seed missing screens for this role
        for code, name, scr_type, reason in needed_screens:
            # Check if suggested screen is already in the screen_seed_backlog to avoid duplication
            cursor.execute("SELECT id FROM screen_seed_backlog WHERE role_id = ? AND suggested_screen_code = ?", (role_id, code))
            existing = cursor.fetchone()
            
            if existing:
                continue

            # Insert missing screen row
            cursor.execute("""
                INSERT INTO screen_seed_backlog (
                    app_id, role_id, suggested_screen_code, suggested_screen_name, 
                    screen_type, priority, reason, seed_status
                ) VALUES (?, ?, ?, ?, ?, 'high', ?, 'pending')
            """, (app_id, role_id, code, name, scr_type, reason))
            
            seeded_count += 1
            print(f"Seeded Backlog: Role '{role_name}' -> Screen '{name}' (Type: {scr_type})")

    conn.commit()
    print(f"\nBacklog Seeding Sweep Complete.")
    print(f"  Successfully seeded: {seeded_count} suggested workflow screens in 'screen_seed_backlog'.")

    # Double check view outputs
    cursor.execute("SELECT coverage_status, count(*) FROM v_role_screen_coverage GROUP BY coverage_status;")
    for r in cursor.fetchall():
        print(f"  Role coverage status '{r[0]}': {r[1]} roles")

    conn.close()

if __name__ == "__main__":
    setup_backlog_table()
