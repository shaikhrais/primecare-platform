import sqlite3
import os
import sys

PROJECT_ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
DB_PATH = os.path.join(PROJECT_ROOT, ".agents", "governance", "governance.db")

# Exact domain screens specification from USER
screens_data = [
    # CEO
    {"role": "ceo", "app": 7, "folder": "executive", "name": "ExecutiveCommandCenterScreen"},
    {"role": "ceo", "app": 7, "folder": "executive", "name": "EnterpriseHealthScreen"},
    {"role": "ceo", "app": 7, "folder": "executive", "name": "RevenueAnalyticsScreen"},
    {"role": "ceo", "app": 7, "folder": "executive", "name": "RiskManagementScreen"},
    {"role": "ceo", "app": 7, "folder": "executive", "name": "FranchiseOverviewScreen"},
    
    # COO
    {"role": "coo", "app": 7, "folder": "executive", "name": "OperationsCommandCenterScreen"},
    {"role": "coo", "app": 7, "folder": "executive", "name": "StaffingOverviewScreen"},
    {"role": "coo", "app": 7, "folder": "executive", "name": "WorkflowIssueScreen"},
    {"role": "coo", "app": 7, "folder": "executive", "name": "ServiceQualityScreen"},
    {"role": "coo", "app": 7, "folder": "executive", "name": "BranchPerformanceScreen"},
    
    # CFO
    {"role": "cfo", "app": 7, "folder": "executive", "name": "FinancialDashboardScreen"},
    {"role": "cfo", "app": 7, "folder": "executive", "name": "RevenueScreen"},
    {"role": "cfo", "app": 7, "folder": "executive", "name": "ExpenseManagementScreen"},
    {"role": "cfo", "app": 7, "folder": "executive", "name": "PayrollScreen"},
    {"role": "cfo", "app": 7, "folder": "executive", "name": "TaxComplianceScreen"},
    
    # CTO
    {"role": "cto", "app": 7, "folder": "executive", "name": "SystemHealthScreen"},
    {"role": "cto", "app": 7, "folder": "executive", "name": "ApiMonitoringScreen"},
    {"role": "cto", "app": 7, "folder": "executive", "name": "DeploymentCenterScreen"},
    {"role": "cto", "app": 7, "folder": "executive", "name": "SecurityAuditScreen"},
    {"role": "cto", "app": 7, "folder": "executive", "name": "ReleaseManagementScreen"},
    
    # Compliance Manager
    {"role": "compliance", "app": 5, "folder": "management", "name": "ComplianceDashboardScreen"},
    {"role": "compliance", "app": 5, "folder": "management", "name": "AuditReviewScreen"},
    {"role": "compliance", "app": 5, "folder": "management", "name": "IncidentManagementScreen"},
    {"role": "compliance", "app": 5, "folder": "management", "name": "PolicyManagementScreen"},
    {"role": "compliance", "app": 5, "folder": "management", "name": "CorrectiveActionScreen"},
    
    # HR Director
    {"role": "hr_director", "app": 5, "folder": "management", "name": "HiringPipelineScreen"},
    {"role": "hr_director", "app": 5, "folder": "management", "name": "EmployeeRecordsScreen"},
    {"role": "hr_director", "app": 5, "folder": "management", "name": "CredentialExpiryScreen"},
    {"role": "hr_director", "app": 5, "folder": "management", "name": "TrainingManagementScreen"},
    {"role": "hr_director", "app": 5, "folder": "management", "name": "OnboardingScreen"},
    
    # Business Development Director
    {"role": "bus_dev", "app": 4, "folder": "management", "name": "FranchiseLeadScreen"},
    {"role": "bus_dev", "app": 4, "folder": "management", "name": "PartnershipManagementScreen"},
    {"role": "bus_dev", "app": 4, "folder": "management", "name": "GrowthAnalyticsScreen"},
    {"role": "bus_dev", "app": 4, "folder": "management", "name": "OutreachCampaignScreen"},
    
    # Marketing Director
    {"role": "marketing", "app": 11, "folder": "management", "name": "CampaignDashboardScreen"},
    {"role": "marketing", "app": 11, "folder": "management", "name": "LeadAnalyticsScreen"},
    {"role": "marketing", "app": 11, "folder": "management", "name": "SocialMediaScreen"},
    {"role": "marketing", "app": 11, "folder": "management", "name": "BrandManagementScreen"},
    
    # Franchise Owner
    {"role": "owner", "app": 9, "folder": "executive", "name": "FranchiseCommandCenterScreen"},
    {"role": "owner", "app": 9, "folder": "executive", "name": "RevenueSnapshotScreen"},
    {"role": "owner", "app": 9, "folder": "executive", "name": "StaffManagementScreen"},
    {"role": "owner", "app": 9, "folder": "executive", "name": "AppointmentOverviewScreen"},
    {"role": "owner", "app": 9, "folder": "executive", "name": "ComplianceOverviewScreen"},
    
    # Operations Manager
    {"role": "ops_manager", "app": 5, "folder": "management", "name": "DailyOperationsScreen"},
    {"role": "ops_manager", "app": 5, "folder": "management", "name": "AttendanceScreen"},
    {"role": "ops_manager", "app": 5, "folder": "management", "name": "SchedulingHealthScreen"},
    {"role": "ops_manager", "app": 5, "folder": "management", "name": "ServiceIssueScreen"},
    
    # Scheduler
    {"role": "scheduler", "app": 5, "folder": "staff", "name": "SchedulingDashboardScreen"},
    {"role": "scheduler", "app": 5, "folder": "staff", "name": "CalendarManagementScreen"},
    {"role": "scheduler", "app": 5, "folder": "staff", "name": "ConflictResolutionScreen"},
    {"role": "scheduler", "app": 5, "folder": "staff", "name": "OpenShiftScreen"},
    
    # Billing Admin (role: admin)
    {"role": "admin", "app": 5, "folder": "staff", "name": "InvoiceManagementScreen"},
    {"role": "admin", "app": 5, "folder": "staff", "name": "ClaimsProcessingScreen"},
    {"role": "admin", "app": 5, "folder": "staff", "name": "PaymentTrackingScreen"},
    {"role": "admin", "app": 5, "folder": "staff", "name": "RefundManagementScreen"},
    
    # HR Hiring Coordinator (role: hr_hiring)
    {"role": "hr_hiring", "app": 5, "folder": "staff", "name": "ApplicantTrackingScreen"},
    {"role": "hr_hiring", "app": 5, "folder": "staff", "name": "InterviewSchedulingScreen"},
    {"role": "hr_hiring", "app": 5, "folder": "staff", "name": "OfferManagementScreen"},
    {"role": "hr_hiring", "app": 5, "folder": "staff", "name": "OnboardingChecklistScreen"},
    
    # RN
    {"role": "rn", "app": 6, "folder": "rn", "name": "PatientChartingScreen"},
    {"role": "rn", "app": 6, "folder": "rn", "name": "MedicationAdministrationScreen"},
    {"role": "rn", "app": 6, "folder": "rn", "name": "CarePlanReviewScreen"},
    {"role": "rn", "app": 6, "folder": "rn", "name": "IncidentReviewScreen"},
    {"role": "rn", "app": 6, "folder": "rn", "name": "ShiftReportScreen"},
    
    # RPN
    {"role": "rpn", "app": 6, "folder": "clinical", "name": "NursingTaskScreen"},
    {"role": "rpn", "app": 6, "folder": "clinical", "name": "VitalsTrackingScreen"},
    {"role": "rpn", "app": 6, "folder": "clinical", "name": "MedicationScreen"},
    {"role": "rpn", "app": 6, "folder": "clinical", "name": "PatientObservationScreen"},
    
    # PSW
    {"role": "psw", "app": 6, "folder": "psw", "name": "PswCommandCenterScreen"},
    {"role": "psw", "app": 6, "folder": "psw", "name": "ShiftTasksScreen"},
    {"role": "psw", "app": 6, "folder": "psw", "name": "VisitNotesScreen"},
    {"role": "psw", "app": 6, "folder": "psw", "name": "VitalsEntryScreen"},
    {"role": "psw", "app": 6, "folder": "psw", "name": "IncidentReportScreen"},
    
    # Physiotherapist (physio)
    {"role": "physio", "app": 6, "folder": "clinical", "name": "AssessmentScreen"},
    {"role": "physio", "app": 6, "folder": "clinical", "name": "TreatmentPlanScreen"},
    {"role": "physio", "app": 6, "folder": "clinical", "name": "ExercisePrescriptionScreen"},
    {"role": "physio", "app": 6, "folder": "clinical", "name": "ProgressTrackingScreen"},
    
    # RMT
    {"role": "rmt", "app": 5, "folder": "allied", "name": "MassageAssessmentScreen"},
    {"role": "rmt", "app": 5, "folder": "allied", "name": "TreatmentNotesScreen"},
    {"role": "rmt", "app": 5, "folder": "allied", "name": "HomeCarePlanScreen"},
    {"role": "rmt", "app": 5, "folder": "allied", "name": "ClientProgressScreen"},
    
    # Chiropractor
    {"role": "chiropractor", "app": 5, "folder": "allied", "name": "ChiropracticAssessmentScreen"},
    {"role": "chiropractor", "app": 5, "folder": "allied", "name": "AdjustmentNotesScreen"},
    {"role": "chiropractor", "app": 5, "folder": "allied", "name": "XrayReviewScreen"},
    {"role": "chiropractor", "app": 5, "folder": "allied", "name": "ChiropracticProgressTrackingScreen"},
    
    # Intake Coordinator
    {"role": "intake", "app": 6, "folder": "executive", "name": "ReferralManagementScreen"},
    {"role": "intake", "app": 6, "folder": "executive", "name": "ClientIntakeScreen"},
    {"role": "intake", "app": 6, "folder": "executive", "name": "BookingScreen"},
    {"role": "intake", "app": 6, "folder": "executive", "name": "FollowupScreen"},
    
    # Clinical Director
    {"role": "clinical_director", "app": 6, "folder": "clinical", "name": "ClinicalQualityScreen"},
    {"role": "clinical_director", "app": 6, "folder": "clinical", "name": "StaffPerformanceScreen"},
    {"role": "clinical_director", "app": 6, "folder": "clinical", "name": "ComplianceReviewScreen"},
    {"role": "clinical_director", "app": 6, "folder": "clinical", "name": "IncidentOversightScreen"},
    
    # Customer Support
    {"role": "customer_support", "app": 5, "folder": "staff", "name": "TicketManagementScreen"},
    {"role": "customer_support", "app": 5, "folder": "staff", "name": "ClientIssueScreen"},
    {"role": "customer_support", "app": 5, "folder": "staff", "name": "CommunicationScreen"},
    {"role": "customer_support", "app": 5, "folder": "staff", "name": "ResolutionTrackingScreen"},
    
    # Training Coordinator
    {"role": "training_coordinator", "app": 5, "folder": "staff", "name": "TrainingDashboardScreen"},
    {"role": "training_coordinator", "app": 5, "folder": "staff", "name": "CourseAssignmentScreen"},
    {"role": "training_coordinator", "app": 5, "folder": "staff", "name": "CertificationTrackingScreen"},
    {"role": "training_coordinator", "app": 5, "folder": "staff", "name": "StaffProgressScreen"},
    
    # QA Specialist
    {"role": "qa_specialist", "app": 5, "folder": "staff", "name": "QualityAuditScreen"},
    {"role": "qa_specialist", "app": 5, "folder": "staff", "name": "FailedWorkflowScreen"},
    {"role": "qa_specialist", "app": 5, "folder": "staff", "name": "TestingOverviewScreen"},
    {"role": "qa_specialist", "app": 5, "folder": "staff", "name": "DefectTrackingScreen"},
    
    # Patient
    {"role": "patient", "app": 5, "folder": "common", "name": "PatientDashboardScreen"},
    {"role": "patient", "app": 5, "folder": "common", "name": "AppointmentScreen"},
    {"role": "patient", "app": 5, "folder": "common", "name": "CarePlanScreen"},
    {"role": "patient", "app": 5, "folder": "common", "name": "BillingScreen"},
    {"role": "patient", "app": 5, "folder": "common", "name": "DocumentsScreen"},
    
    # Family Member
    {"role": "family", "app": 5, "folder": "common", "name": "FamilyOverviewScreen"},
    {"role": "family", "app": 5, "folder": "common", "name": "CareUpdatesScreen"},
    {"role": "family", "app": 5, "folder": "common", "name": "BillingOverviewScreen"},
    {"role": "family", "app": 5, "folder": "common", "name": "EmergencyContactsScreen"},
    
    # Caregiver
    {"role": "caregiver", "app": 5, "folder": "psw", "name": "CaregiverTasksScreen"},
    {"role": "caregiver", "app": 5, "folder": "psw", "name": "ScheduleScreen"},
    {"role": "caregiver", "app": 5, "folder": "psw", "name": "VisitNotesScreen"},
    {"role": "caregiver", "app": 5, "folder": "psw", "name": "MessagingScreen"},
    
    # System / Governance
    {"role": "governance", "app": 10, "folder": "common", "name": "GovernanceControlRoomScreen"},
    {"role": "governance", "app": 10, "folder": "common", "name": "RuntimeVerificationScreen"},
    {"role": "governance", "app": 10, "folder": "common", "name": "DriftFindingsScreen"},
    {"role": "governance", "app": 10, "folder": "common", "name": "PendingTaskQueueScreen"},
    {"role": "governance", "app": 10, "folder": "common", "name": "AgentDispatchScreen"},
    {"role": "governance", "app": 10, "folder": "common", "name": "ScreenAuditScreen"},
    {"role": "governance", "app": 10, "folder": "common", "name": "ApiHealthDashboardScreen"},
    {"role": "governance", "app": 10, "folder": "common", "name": "ReleaseOperationsScreen"},
    {"role": "governance", "app": 10, "folder": "common", "name": "FileVerificationDashboardScreen"},
    {"role": "governance", "app": 10, "folder": "common", "name": "RoleCoverageDashboardScreen"},
    {"role": "governance", "app": 10, "folder": "common", "name": "ResponsivePreviewScreen"},
    {"role": "governance", "app": 10, "folder": "common", "name": "WorkflowExecutionScreen"},
    
    # Large 4K Command Center Screens
    {"role": "ceo", "app": 7, "folder": "executive", "name": "EnterpriseCommandCenter4KScreen"},
    {"role": "owner", "app": 9, "folder": "executive", "name": "FranchiseCommandCenter4KScreen"},
    {"role": "clinical_director", "app": 6, "folder": "clinical", "name": "ClinicalOperations4KScreen"},
    {"role": "governance", "app": 10, "folder": "common", "name": "GovernanceOperations4KScreen"},
    {"role": "scheduler", "app": 5, "folder": "staff", "name": "SchedulingOperations4KScreen"},
    {"role": "cfo", "app": 7, "folder": "executive", "name": "FinancialOperations4KScreen"}
]

def seed_backlog():
    print("=====================================================")
    print("Executing Premium Domain Registry Seeding Sweep")
    print("=====================================================")
    
    if not os.path.exists(DB_PATH):
        print(f"Error: Relational database not found at {DB_PATH}")
        sys.exit(1)
        
    conn = sqlite3.connect(DB_PATH)
    conn.row_factory = sqlite3.Row
    cursor = conn.cursor()
    
    # 1. Clean up the temporary screens and tasks we enqueued in the generic coverage sweep
    print("Performing database housekeeping - removing generic placeholder screens...")
    
    # Select newly inserted planned screen IDs
    cursor.execute("SELECT id FROM screens WHERE screen_status = 'planned' AND verification_status = 'pending';")
    del_screen_ids = [r['id'] for r in cursor.fetchall()]
    
    if del_screen_ids:
        # Delete related tasks
        placeholders = ",".join(["?"] * len(del_screen_ids))
        cursor.execute(f"DELETE FROM implementation_tasks WHERE related_screen_id IN ({placeholders});", del_screen_ids)
        print(f"  Cleaned {cursor.rowcount} pending placeholder tasks.")
        
        # Delete screens
        cursor.execute(f"DELETE FROM screens WHERE id IN ({placeholders});", del_screen_ids)
        print(f"  Cleaned {cursor.rowcount} placeholder planned screens.")
        
    # 2. Insert missing custom roles
    custom_roles = [
        {"code": "customer_support", "name": "Customer Support"},
        {"code": "training_coordinator", "name": "Training Coordinator"},
        {"code": "qa_specialist", "name": "QA Specialist"},
        {"code": "family", "name": "Family Member"}
    ]
    
    print("\nEnsuring all custom roles exist in roles table...")
    for cr in custom_roles:
        cursor.execute("""
            INSERT OR IGNORE INTO roles (org_id, role_code, role_name, role_level, status)
            VALUES (1, ?, ?, 1, 'active');
        """, (cr['code'], cr['name']))
        if cursor.rowcount > 0:
            print(f"  [NEW ROLE] Registered role: '{cr['name']}' ({cr['code']})")
            
    # 3. Seed exact 133 screens
    print("\nSeeding 133 custom domain screens and backlog tasks...")
    screens_seeded = 0
    tasks_seeded = 0
    
    for s in screens_data:
        r_code = s['role']
        app_id = s['app']
        folder = s['folder']
        scr_name = s['name']
        
        # Look up role ID
        cursor.execute("SELECT id FROM roles WHERE role_code = ? LIMIT 1;", (r_code,))
        role_row = cursor.fetchone()
        if not role_row:
            print(f"  [ERROR] Role not found for code: '{r_code}' (skipped screen: {scr_name})")
            continue
            
        role_id = role_row['id']
        
        # Format code, path, and route
        base_name = scr_name.replace("Screen", "")
        # convert CamelCase to snake_case for screen code
        scr_code = re.sub(r'(?<!^)(?=[A-Z])', '_', base_name).lower()
        route_path = f"/{folder}/{scr_code.replace('_', '-')}"
        expected_file_path = f"packages/primecare_ui/lib/src/screens/{folder}/{scr_code}_screen.dart"
        
        # Determine screen type
        if "Dashboard" in scr_name or "CommandCenter" in scr_name or "Operations4K" in scr_name or "ControlRoom" in scr_name:
            scr_type = "dashboard"
        elif "Queue" in scr_name or "Pipeline" in scr_name or "Overview" in scr_name or "List" in scr_name or "Tracking" in scr_name or "Monitoring" in scr_name or "Audit" in scr_name:
            scr_type = "workflow"
        else:
            scr_type = "crud"
            
        # Check if screen already exists in registry
        cursor.execute("SELECT id FROM screens WHERE screen_name = ? OR route_path = ?;", (scr_name, route_path))
        exist_row = cursor.fetchone()
        if exist_row:
            # Already exists in the database
            continue
            
        # Insert new screen
        cursor.execute("""
            INSERT INTO screens 
            (app_id, role_id, screen_code, screen_name, route_path, expected_file_path, screen_type, screen_status, verification_status)
            VALUES (?, ?, ?, ?, ?, ?, ?, 'planned', 'pending');
        """, (
            app_id,
            role_id,
            scr_code,
            scr_name,
            route_path,
            expected_file_path,
            scr_type
        ))
        
        new_screen_id = cursor.lastrowid
        screens_seeded += 1
        
        # Insert corresponding task
        cursor.execute("""
            INSERT INTO implementation_tasks
            (app_id, task_title, task_description, priority, task_type, related_screen_id, assigned_agent, status)
            VALUES (?, ?, ?, 'high', 'screen_interaction_audit', ?, 'antigravity_agent', 'pending');
        """, (
            app_id,
            f"Scaffold and verify screen: {scr_name}",
            f"Implement high-fidelity widget, verify import, class, route, and physical rendering for {scr_name}",
            new_screen_id
        ))
        tasks_seeded += 1
        
    conn.commit()
    conn.close()
    
    print("\n=====================================================")
    print("Backlog seeding sweep successfully completed!")
    print(f"Total screens seeded successfully: {screens_seeded}")
    print(f"Total tasks enqueued successfully: {tasks_seeded}")
    print("=====================================================")

if __name__ == "__main__":
    import re
    seed_backlog()
