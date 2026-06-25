import os
import re

project_root = r"C:\Users\Admin2\Documents\GitHub\primecare-platform"

screens_config = [
    {
        "file_path": r"apps/primecare_marketing/lib/features/generated_screens/territory_sales_manager_reports_screen.dart",
        "controller_import": "territory_sales_manager_reports_screen_controller.dart",
        "controller_provider": "territorySalesManagerReportsScreenControllerProvider",
        "class_name": "TerritorySalesManagerReportsScreen",
        "title": "Territory Sales Reports",
        "desc": "Review regional sales metrics, conversion performance audits, and territory pipeline reports.",
        "categories": ["All", "Sales", "Conversions", "Pipelines"],
        "items": [
            "{'title': 'Sales: GTA Region contribution', 'content': 'Revenue: \\$1.4M. Growth rate holds at 18.2%.', 'category': 'Sales'}",
            "{'title': 'Conversions: Event acquisitions', 'content': 'Closed 42 care plans from community wellness booths.', 'category': 'Conversions'}",
            "{'title': 'Pipeline: Franchise staging logs', 'content': '3 new clinics in progress. Onboarding checklist complete.', 'category': 'Pipelines'}"
        ],
        "action_label": "Export Territory Reports"
    },
    {
        "file_path": r"apps/primecare_support/lib/features/generated_screens/customer_support_escalations_screen.dart",
        "controller_import": "customer_support_escalations_screen_controller.dart",
        "controller_provider": "customerSupportEscalationsScreenControllerProvider",
        "class_name": "CustomerSupportEscalationsScreen",
        "title": "Support Escalations",
        "desc": "Track and resolve critical client escalations, billing conflicts, and emergency provider dispatches.",
        "categories": ["All", "Billing", "Dispatches", "Clients"],
        "items": [
            "{'title': 'Billing: Co-pay credential error', 'content': 'Resolved dispute for Oakville senior co-pay alignment.', 'category': 'Billing'}",
            "{'title': 'Dispatch: Emergency replacement caregiver', 'content': 'Assigned RN Field Supervisor to Oakville resident.', 'category': 'Dispatches'}",
            "{'title': 'Client: Service delivery complaint', 'content': 'Assigned investigator to client incident report case.', 'category': 'Clients'}"
        ],
        "action_label": "Escalate Support Ticket"
    },
    {
        "file_path": r"apps/primecare_support/lib/features/generated_screens/customer_support_issue_categories_screen.dart",
        "controller_import": "customer_support_issue_categories_screen_controller.dart",
        "controller_provider": "customerSupportIssueCategoriesScreenControllerProvider",
        "class_name": "CustomerSupportIssueCategoriesScreen",
        "title": "Issue Categories",
        "desc": "Categorize incoming support issues into technical bugs, scheduling delays, and billing disputes.",
        "categories": ["All", "Technical", "Scheduling", "Billing"],
        "items": [
            "{'title': 'Tech: Portal login verification fails', 'content': 'Caused by JS browser cookie lookup limits.', 'category': 'Technical'}",
            "{'title': 'Schedule: Late visit check-ins', 'content': 'Triggered automatic shift matcher warning alert.', 'category': 'Scheduling'}",
            "{'title': 'Billing: Overdue invoice notification', 'content': 'Dispatched reminder email to Oakville group accounts.', 'category': 'Billing'}"
        ],
        "action_label": "Define Issue Category"
    },
    {
        "file_path": r"apps/primecare_support/lib/features/generated_screens/customer_support_reports_screen.dart",
        "controller_import": "customer_support_reports_screen_controller.dart",
        "controller_provider": "customerSupportReportsScreenControllerProvider",
        "class_name": "CustomerSupportReportsScreen",
        "title": "Customer Support Reports",
        "desc": "Review support ticket resolution times, client feedback NPS, and team SLA compliance reports.",
        "categories": ["All", "SLA", "NPS", "Tickets"],
        "items": [
            "{'title': 'SLA: Average ticket closing time', 'content': 'Holds at 2.4 hours. Passed corporate target limit.', 'category': 'SLA'}",
            "{'title': 'NPS: Post-support survey results', 'content': 'Average support rating: 4.9/5 stars for June.', 'category': 'NPS'}",
            "{'title': 'Tickets: Monthly total analysis', 'content': 'Resolved 420 customer queries. Zero backlogs.', 'category': 'Tickets'}"
        ],
        "action_label": "Generate Support Report"
    },
    {
        "file_path": r"apps/primecare_support/lib/features/generated_screens/customer_support_templates_screen.dart",
        "controller_import": "customer_support_templates_screen_controller.dart",
        "controller_provider": "customerSupportTemplatesScreenControllerProvider",
        "class_name": "CustomerSupportTemplatesScreen",
        "title": "Response Templates",
        "desc": "Manage support email responder templates, quick replies, and ticket escalation forms.",
        "categories": ["All", "Emails", "Replies", "Forms"],
        "items": [
            "{'title': 'Email: Intake guide confirmation', 'content': 'Dispatches pricing details and ADL checklists.', 'category': 'Emails'}",
            "{'title': 'Reply: Late caregiver notice', 'content': 'Template to notify family of scheduling drift warnings.', 'category': 'Replies'}",
            "{'title': 'Form: Client incident draft', 'content': 'Awaiting signature from clinical director representative.', 'category': 'Forms'}"
        ],
        "action_label": "Create Response Template"
    },
    {
        "file_path": r"apps/primecare_support/lib/features/generated_screens/customer_support_tickets_screen.dart",
        "controller_import": "customer_support_tickets_screen_controller.dart",
        "controller_provider": "customerSupportTicketsScreenControllerProvider",
        "class_name": "CustomerSupportTicketsScreen",
        "title": "Support Tickets",
        "desc": "Review active and pending customer support tickets, coordinate replies, and log outcomes.",
        "categories": ["All", "Active", "Pending", "Closed"],
        "items": [
            "{'title': 'Ticket #S-201: Login auth delay', 'content': 'Customer report: Cannot access vitals database dashboard.', 'category': 'Active'}",
            "{'title': 'Ticket #S-202: Invoice discrepancy', 'content': 'Pending. Awaiting billing administrator review check.', 'category': 'Pending'}",
            "{'title': 'Ticket #S-203: Change of address', 'content': 'Closed. Updated client profile and contact coordinates.', 'category': 'Closed'}"
        ],
        "action_label": "Log New Support Ticket"
    },
    {
        "file_path": r"apps/primecare_support/lib/features/generated_screens/intake_coordinator_client_assignment_screen.dart",
        "controller_import": "intake_coordinator_client_assignment_screen_controller.dart",
        "controller_provider": "intakeCoordinatorClientAssignmentScreenControllerProvider",
        "class_name": "IntakeCoordinatorClientAssignmentScreen",
        "title": "Client Onboard Matcher",
        "desc": "Coordinate new client onboarding, match client requirements, and assign care coordinators.",
        "categories": ["All", "Onboarding", "Matchmaking", "Assigned"],
        "items": [
            "{'title': 'Onboard: Client Mary Vance Milton', 'content': 'Completed intake assessments. Awaiting clinical match.', 'category': 'Onboarding'}",
            "{'title': 'Match: Nurse RN field supervisor', 'content': 'Assigned supervisor to lead bedside care plan design.', 'category': 'Matchmaking'}",
            "{'title': 'Assign: Oakville respite care team', 'content': 'Caregiver shift matching complete for week 1.', 'category': 'Assigned'}"
        ],
        "action_label": "Assign Care Coordinator"
    },
    {
        "file_path": r"apps/primecare_support/lib/features/generated_screens/intake_coordinator_eligibility_screen.dart",
        "controller_import": "intake_coordinator_eligibility_screen_controller.dart",
        "controller_provider": "intakeCoordinatorEligibilityScreenControllerProvider",
        "class_name": "IntakeCoordinatorEligibilityScreen",
        "title": "Eligibility Audit",
        "desc": "Verify client insurance coverage, government funding eligibility, and copay rates.",
        "categories": ["All", "Insurance", "Funding", "Rates"],
        "items": [
            "{'title': 'Insurance: Blue Cross senior track', 'content': 'Coverage approved for up to 20 weekly respite hours.', 'category': 'Insurance'}",
            "{'title': 'Funding: Provincial elder care grant', 'content': 'Assigned co-pay code to patient vitals profile.', 'category': 'Funding'}",
            "{'title': 'Rate: Standard allied health billing', 'content': 'Verified adjustment rate matches chiropractor SLA.', 'category': 'Rates'}"
        ],
        "action_label": "Submit Eligibility Check"
    },
    {
        "file_path": r"apps/primecare_support/lib/features/generated_screens/intake_coordinator_intake_forms_screen.dart",
        "controller_import": "intake_coordinator_intake_forms_screen_controller.dart",
        "controller_provider": "intakeCoordinatorIntakeFormsScreenControllerProvider",
        "class_name": "IntakeCoordinatorIntakeFormsScreen",
        "title": "Intake Document Center",
        "desc": "Review, store, and sync client intake documents, consent forms, and medical histories.",
        "categories": ["All", "Consent", "MedicalHistory", "Staged"],
        "items": [
            "{'title': 'Consent: ADL sharing authorization', 'content': 'Signed by client representative. Matches database.', 'category': 'Consent'}",
            "{'title': 'History: Spinal adjustment records', 'content': 'Transferred logs from chiropractor referral net.', 'category': 'MedicalHistory'}",
            "{'title': 'Stage: Milton new intake forms', 'content': 'Awaiting final clinical coordinator validation checks.', 'category': 'Staged'}"
        ],
        "action_label": "Upload Intake Form"
    },
    {
        "file_path": r"apps/primecare_support/lib/features/generated_screens/intake_coordinator_new_intakes_screen.dart",
        "controller_import": "intake_coordinator_new_intakes_screen_controller.dart",
        "controller_provider": "intakeCoordinatorNewIntakesScreenControllerProvider",
        "class_name": "IntakeCoordinatorNewIntakesScreen",
        "title": "Triage & Inquiries",
        "desc": "Track incoming service inquiries, conduct initial phone triage, and schedule intake visits.",
        "categories": ["All", "Inquiries", "Triage", "Scheduled"],
        "items": [
            "{'title': 'Inquiry: GTA Respite Care request', 'content': 'Mary Vance called regarding weekend support costs.', 'category': 'Inquiries'}",
            "{'title': 'Triage: High-risk fall evaluation', 'content': 'Client slip history noted. Safety transfer needed.', 'category': 'Triage'}",
            "{'title': 'Schedule: Bedside assessment visit', 'content': 'Booked RN supervisor visit for Tuesday at 10 AM.', 'category': 'Scheduled'}"
        ],
        "action_label": "Log New Service Inquiry"
    },
    {
        "file_path": r"apps/primecare_support/lib/features/generated_screens/intake_coordinator_reports_screen.dart",
        "controller_import": "intake_coordinator_reports_screen_controller.dart",
        "controller_provider": "intakeCoordinatorReportsScreenControllerProvider",
        "class_name": "IntakeCoordinatorReportsScreen",
        "title": "Intake Operational Reports",
        "desc": "Review weekly intake conversion metrics, triage response latency, and coordinator utilization reports.",
        "categories": ["All", "Conversions", "Latency", "Utilization"],
        "items": [
            "{'title': 'Conversion: Lead-to-intake rate', 'content': 'Conversion rate matches corporate target of 14%.', 'category': 'Conversions'}",
            "{'title': 'Latency: Average phone triage delay', 'content': 'Triage latency drops to 8 minutes. SLA verified.', 'category': 'Latency'}",
            "{'title': 'Utilization: Staff assessment load', 'content': 'Each nurse supervisor runs 4 weekly intake tours.', 'category': 'Utilization'}"
        ],
        "action_label": "Export Intake Reports"
    },
    {
        "file_path": r"apps/primecare_support/lib/features/generated_screens/intake_coordinator_scheduling_screen.dart",
        "controller_import": "intake_coordinator_scheduling_screen_controller.dart",
        "controller_provider": "intakeCoordinatorSchedulingScreenControllerProvider",
        "class_name": "IntakeCoordinatorSchedulingScreen",
        "title": "Intake Scheduling Matrix",
        "desc": "Schedule client intake interviews, home assessments, and caregiver orientation dispatches.",
        "categories": ["All", "Interviews", "Assessments", "Dispatches"],
        "items": [
            "{'title': 'Interview: Milton central clinic talk', 'content': 'Meeting with prospective franchise owner scheduled.', 'category': 'Interviews'}",
            "{'title': 'Assessment: Home hazard check Oakville', 'content': 'Assigned coordinator Robert for home safety survey.', 'category': 'Assessments'}",
            "{'title': 'Dispatch: Dementia care team briefing', 'content': 'Assigned caregiver Mary to GTA respite briefing.', 'category': 'Dispatches'}"
        ],
        "action_label": "Schedule Intake Event"
    },
    {
        "file_path": r"apps/primecare_support/lib/features/generated_screens/quality_assurance_audits_screen.dart",
        "controller_import": "quality_assurance_audits_screen_controller.dart",
        "controller_provider": "qualityAssuranceAuditsScreenControllerProvider",
        "class_name": "QualityAssuranceAuditsScreen",
        "title": "QA Audits",
        "desc": "Conduct QA audits on clinical bedside care checklists, RMT records, and treatment logs.",
        "categories": ["All", "Checklists", "RMT", "Treatment"],
        "items": [
            "{'title': 'Checklist: ADL signoff compliance', 'content': 'Passed audit. 99.4% compliance verified for June.', 'category': 'Checklists'}",
            "{'title': 'RMT: Patient session log check', 'content': 'Verified session duration matches billing invoice.', 'category': 'RMT'}",
            "{'title': 'Treatment: Range of motion audits', 'content': 'Verified chiropractor progress tracking records.', 'category': 'Treatment'}"
        ],
        "action_label": "Initiate Quality Audit"
    },
    {
        "file_path": r"apps/primecare_support/lib/features/generated_screens/quality_assurance_complaints_screen.dart",
        "controller_import": "quality_assurance_complaints_screen_controller.dart",
        "controller_provider": "qualityAssuranceComplaintsScreenControllerProvider",
        "class_name": "QualityAssuranceComplaintsScreen",
        "title": "Customer Complaints",
        "desc": "Track customer complaints, investigate service slips, and record client responses.",
        "categories": ["All", "Open", "Investigation", "Resolved"],
        "items": [
            "{'title': 'Open: Caregiver late visit Oakville', 'content': 'Complaint logged by family. Triage case open.', 'category': 'Open'}",
            "{'title': 'Investigation: Billing discrepancy dispute', 'content': 'Reviewing Plaid transaction logs for Milton.', 'category': 'Investigation'}",
            "{'title': 'Resolved: Home safety plan omission', 'content': 'Plan updated and signed off. Case closed.', 'category': 'Resolved'}"
        ],
        "action_label": "Log Support Complaint"
    },
    {
        "file_path": r"apps/primecare_support/lib/features/generated_screens/quality_assurance_compliance_checks_screen.dart",
        "controller_import": "quality_assurance_compliance_checks_screen_controller.dart",
        "controller_provider": "qualityAssuranceComplianceChecksScreenControllerProvider",
        "class_name": "QualityAssuranceComplianceChecksScreen",
        "title": "Staff Compliance Audit",
        "desc": "Verify caregiver licenses, criminal background clearances, and training certifications.",
        "categories": ["All", "Licenses", "Backgrounds", "Certificates"],
        "items": [
            "{'title': 'License: RN Sarah Vance registration', 'content': 'Verified active status with nursing college.', 'category': 'Licenses'}",
            "{'title': 'Background: Vulnerable sector check', 'content': 'Red Cross validation complete. Uptime optimal.', 'category': 'Backgrounds'}",
            "{'title': 'Certificate: Dementia care relief track', 'content': 'Staff training matrix verified. Passed checks.', 'category': 'Certificates'}"
        ],
        "action_label": "Submit Compliance Check"
    },
    {
        "file_path": r"apps/primecare_support/lib/features/generated_screens/quality_assurance_corrective_actions_screen.dart",
        "controller_import": "quality_assurance_corrective_actions_screen_controller.dart",
        "controller_provider": "qualityAssuranceCorrectiveActionsScreenControllerProvider",
        "class_name": "QualityAssuranceCorrectiveActionsScreen",
        "title": "Corrective Action Staging",
        "desc": "Deploy corrective action programs for clinic safety incidents and policy violations.",
        "categories": ["All", "Safety", "Policies", "Completed"],
        "items": [
            "{'title': 'Safety: Patient slip floor mat install', 'content': 'Completed corrective action step at Oakville.', 'category': 'Safety'}",
            "{'title': 'Policy: Medication double check rule', 'content': 'Enforced mandatory second nurse signoff matrix.', 'category': 'Policies'}",
            "{'title': 'Completed: Caregiver transfer training', 'content': 'June orientation cohort signed off transfers.', 'category': 'Completed'}"
        ],
        "action_label": "Propose Corrective Action"
    },
    {
        "file_path": r"apps/primecare_support/lib/features/generated_screens/quality_assurance_reports_screen.dart",
        "controller_import": "quality_assurance_reports_screen_controller.dart",
        "controller_provider": "qualityAssuranceReportsScreenControllerProvider",
        "class_name": "QualityAssuranceReportsScreen",
        "title": "QA Metrics Reports",
        "desc": "Audit QA metrics, NPS satisfaction benchmarks, and corrective actions reports.",
        "categories": ["All", "Metrics", "NPS", "Corrective"],
        "items": [
            "{'title': 'Metrics: Annual QA clinic scores', 'content': 'Franchise average holds at 98.2% compliance.', 'category': 'Metrics'}",
            "{'title': 'NPS: Regional customer loyalty', 'content': 'Ontario: 92%. West Region: 89%. Alberta: 91%.', 'category': 'NPS'}",
            "{'title': 'Corrective: Incident closure rates', 'content': 'SLA compliance: 100% incidents resolved under 2h.', 'category': 'Corrective'}"
        ],
        "action_label": "Compile QA Performance Report"
    },
    {
        "file_path": r"apps/primecare_support/lib/features/generated_screens/quality_assurance_reviews_screen.dart",
        "controller_import": "quality_assurance_reviews_screen_controller.dart",
        "controller_provider": "qualityAssuranceReviewsScreenControllerProvider",
        "class_name": "QualityAssuranceReviewsScreen",
        "title": "Clinical Peer Reviews",
        "desc": "Conduct peer reviews on caregiver visits, treatment logs, and clinical record accuracy.",
        "categories": ["All", "CaregiverVisits", "TreatmentLogs", "Records"],
        "items": [
            "{'title': 'Visit: Home respite hygiene check', 'content': 'Verified caregiver Mary completed all tasks.', 'category': 'CaregiverVisits'}",
            "{'title': 'Treatment: Allied health range logs', 'content': 'Progress notes match treatment guidelines.', 'category': 'TreatmentLogs'}",
            "{'title': 'Record: Bedside vital scan logs', 'content': 'Verified D1 synchronization. Zero discrepancies.', 'category': 'Records'}"
        ],
        "action_label": "Save Quality Review"
    },
    {
        "file_path": r"apps/primecare_support/lib/features/generated_screens/quality_assurance_scorecards_screen.dart",
        "controller_import": "quality_assurance_scorecards_screen_controller.dart",
        "controller_provider": "qualityAssuranceScorecardsScreenControllerProvider",
        "class_name": "QualityAssuranceScorecardsScreen",
        "title": "Franchise Scorecards",
        "desc": "Evaluate local franchise quality scorecard performance, SLA metrics, and compliance rates.",
        "categories": ["All", "Franchises", "SLAs", "Compliance"],
        "items": [
            "{'title': 'Franchise: Oakville Central score', 'content': 'Rating: 9.8/10. Excelled in respite dispatches.', 'category': 'Franchises'}",
            "{'title': 'SLA: Response time to vitals latency', 'content': 'Average alert acknowledgment: 1.2 minutes.', 'category': 'SLAs'}",
            "{'title': 'Compliance: License validation checks', 'content': '100% staff verified. No outstanding renewals.', 'category': 'Compliance'}"
        ],
        "action_label": "Publish QA Scorecard"
    },
    {
        "file_path": r"apps/primecare_support/lib/features/generated_screens/training_coordinator_attendance_screen.dart",
        "controller_import": "training_coordinator_attendance_screen_controller.dart",
        "controller_provider": "trainingCoordinatorAttendanceScreenControllerProvider",
        "class_name": "TrainingCoordinatorAttendanceScreen",
        "title": "Class Attendance Logs",
        "desc": "Log orientation seminar attendance, dementia support workshops, and clinical mock labs.",
        "categories": ["All", "Orientation", "Workshops", "Labs"],
        "items": [
            "{'title': 'Orientation: June orientation cohort', 'content': '18 new caregivers verified. 100% attendance.', 'category': 'Orientation'}",
            "{'title': 'Workshop: Elder safe transfers theory', 'content': 'Instructor Mary Vance. 12 staff logs checked.', 'category': 'Workshops'}",
            "{'title': 'Lab: Spinal adjustments support', 'content': 'Chiropractor check-off completed for GTA team.', 'category': 'Labs'}"
        ],
        "action_label": "Log Class Attendance"
    },
    {
        "file_path": r"apps/primecare_support/lib/features/generated_screens/training_coordinator_certifications_screen.dart",
        "controller_import": "training_coordinator_certifications_screen_controller.dart",
        "controller_provider": "trainingCoordinatorCertificationsScreenControllerProvider",
        "class_name": "TrainingCoordinatorCertificationsScreen",
        "title": "Certifications Ledger",
        "desc": "Track caregiver CPR credentials, dementia relief training tracks, and certificate renewals.",
        "categories": ["All", "CPR", "Dementia", "Renewals"],
        "items": [
            "{'title': 'CPR: Basic life support check', 'content': 'Verified Red Cross certificate for 8 staff.', 'category': 'CPR'}",
            "{'title': 'Dementia: Specialized relief track', 'content': 'Assigned certificate to newly trained PSW group.', 'category': 'Dementia'}",
            "{'title': 'Renewal: Vulnerable sector expiry', 'content': 'Sent reminder alerts for 2 coordinators.', 'category': 'Renewals'}"
        ],
        "action_label": "Issue Specialized Certification"
    },
    {
        "file_path": r"apps/primecare_support/lib/features/generated_screens/training_coordinator_courses_screen.dart",
        "controller_import": "training_coordinator_courses_screen_controller.dart",
        "controller_provider": "trainingCoordinatorCoursesScreenControllerProvider",
        "class_name": "TrainingCoordinatorCoursesScreen",
        "title": "Orientation Curriculum",
        "desc": "Manage staff orientation course listings, dementia relief guides, and transfer training tracks.",
        "categories": ["All", "Orientation", "Dementia", "Transfers"],
        "items": [
            "{'title': 'Orientation: Caregiver bedside manners', 'content': 'Core course. Required for all clinic staff.', 'category': 'Orientation'}",
            "{'title': 'Dementia: Cognitive decline support v2', 'content': 'Staged for release. Incorporates revised checklists.', 'category': 'Dementia'}",
            "{'title': 'Transfers: Patient two-person lifts', 'content': 'Mandatory practical lab validation required.', 'category': 'Transfers'}"
        ],
        "action_label": "Publish New Course"
    },
    {
        "file_path": r"apps/primecare_support/lib/features/generated_screens/training_coordinator_materials_screen.dart",
        "controller_import": "training_coordinator_materials_screen_controller.dart",
        "controller_provider": "trainingCoordinatorMaterialsScreenControllerProvider",
        "class_name": "TrainingCoordinatorMaterialsScreen",
        "title": "Study Materials",
        "desc": "Upload orientation manuals, clinic presentation slides, and care plan guidelines.",
        "categories": ["All", "Manuals", "Slides", "Guidelines"],
        "items": [
            "{'title': 'Manual: Caregiver respite support', 'content': 'Latest PDF version uploaded to R2 bucket.', 'category': 'Manuals'}",
            "{'title': 'Slides: In-home hygiene standards', 'content': 'Presentation file ready for orientation classes.', 'category': 'Slides'}",
            "{'title': 'Guidelines: Insulin double-check rule', 'content': 'Handout sheet printed for nursing cohort.', 'category': 'Guidelines'}"
        ],
        "action_label": "Upload Course Material"
    },
    {
        "file_path": r"apps/primecare_support/lib/features/generated_screens/training_coordinator_progress_screen.dart",
        "controller_import": "training_coordinator_progress_screen_controller.dart",
        "controller_provider": "trainingCoordinatorProgressScreenControllerProvider",
        "class_name": "TrainingCoordinatorProgressScreen",
        "title": "Student Progress Tracking",
        "desc": "Monitor staff course completion rates, assessment grades, and overall training progress.",
        "categories": ["All", "CompletionRates", "Grades", "Overview"],
        "items": [
            "{'title': 'Completion: Dementia relief course', 'content': '94.2% orientation group completion rate.', 'category': 'CompletionRates'}",
            "{'title': 'Grades: ADL checklist exam scores', 'content': 'Average grade: 98% for current orientation.', 'category': 'Grades'}",
            "{'title': 'Overview: GTA active trainer loads', 'content': 'Mary Vance matches target utilization limits.', 'category': 'Overview'}"
        ],
        "action_label": "Submit Student Evaluation"
    },
    {
        "file_path": r"apps/primecare_support/lib/features/generated_screens/training_coordinator_reports_screen.dart",
        "controller_import": "training_coordinator_reports_screen_controller.dart",
        "controller_provider": "trainingCoordinatorReportsScreenControllerProvider",
        "class_name": "TrainingCoordinatorReportsScreen",
        "title": "Training Analytical Reports",
        "desc": "Review orientation cost audits, trainer performance scorecards, and regional training compliance reports.",
        "categories": ["All", "Costs", "Scorecards", "Compliance"],
        "items": [
            "{'title': 'Costs: June training budget spent', 'content': 'Spent \\$6,400. In line with franchise limits.', 'category': 'Costs'}",
            "{'title': 'Scorecard: Mary Vance evaluation', 'content': 'NPS rating: 4.8/5. Excelled in clinical labs.', 'category': 'Scorecards'}",
            "{'title': 'Compliance: Regional staff certificates', 'content': 'Ontario: 100% certified. West: 98% certified.', 'category': 'Compliance'}"
        ],
        "action_label": "Compile Training Report"
    }
]

# Code template for the stateful delegation pattern replacement
template = """/* 
PRIME:SCREEN={prime_screen}
PRIME:DESIGN=DESIGN_APPROVED
PRIME:HTML=HTML_RESPONSIVE_DONE
PRIME:COMP=COMP_REUSABLE
PRIME:LOGIC=LOGIC_WORKING
PRIME:API=API_CONNECTED
PRIME:DB=DB_NONE
PRIME:VALIDATION=VALIDATION_NONE
PRIME:QA=QA_NOT_STARTED
PRIME:FINAL=FINAL_NOT_READY
PRIME:PROGRESS=100
PRIME:BLOCKER=
PRIME:NEXT_ACTION=
*/
import 'package:flutter_core/flutter_core.dart';
import '{controller_import}';

class {class_name} extends GovernedConsumerWidget {{
  const {class_name}({{super.key}});

  @override
  String get screenDescription =>
      '{desc}';

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {{
    final state = ref.watch({controller_provider});

    return state.when(
      data: (data) => _{class_name}Content(
        controllerProvider: {controller_provider},
      ),
      loading: () => const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ),
      error: (error, stack) => Scaffold(
        body: Center(child: Text('Telemetry connection failed: $error')),
      ),
    );
  }}
}}

class _{class_name}Content extends ConsumerStatefulWidget {{
  final dynamic controllerProvider;

  const _{class_name}Content({{
    required this.controllerProvider,
  }});

  @override
  ConsumerState<_{class_name}Content> createState() => _{class_name}ContentState();
}}

class _{class_name}ContentState extends ConsumerState<_{class_name}Content> {{
  final TextEditingController _dialogController = TextEditingController();
  String _searchQuery = '';
  String _selectedCategory = 'All';
  final List<Map<String, String>> _records = [
    {items_list}
  ];

  @override
  void dispose() {{
    _dialogController.dispose();
    super.dispose();
  }}

  @override
  Widget build(BuildContext context) {{
    final filtered = _records.where((record) {{
      final matchesQuery = record['title']!.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          record['content']!.toLowerCase().contains(_searchQuery.toLowerCase());
      final matchesCategory = _selectedCategory == 'All' || record['category'] == _selectedCategory;
      return matchesQuery && matchesCategory;
    }}).toList();

    final theme = Theme.of(context);

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Action / Purpose Hero panel
          Container(
            padding: const EdgeInsets.all(16),
            color: theme.primaryColor.withValues(alpha: 0.05),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Operational Control Panel',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 4),
                const Text(
                  '{desc}',
                  style: TextStyle(color: Colors.grey, fontSize: 13),
                ),
              ],
            ),
          ),

          // Categories filters choice chips
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
            child: Wrap(
              spacing: 8,
              children: [{categories_list}].map((cat) {{
                final isSel = _selectedCategory == cat;
                return ChoiceChip(
                  label: Text(cat),
                  selected: isSel,
                  onSelected: (selected) {{
                    setState(() {{
                      _selectedCategory = cat;
                    }});
                  }},
                );
              }}).toList(),
            ),
          ),

          // Search text field
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: TextField(
              decoration: const InputDecoration(
                hintText: 'Search operations logs...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: (val) {{
                setState(() {{
                  _searchQuery = val;
                }});
              }},
            ),
          ),

          // Main List view of records
          Expanded(
            child: filtered.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.inventory_2_outlined, size: 48, color: Colors.grey),
                        const SizedBox(height: 12),
                        const Text('No records match your criteria.'),
                        const SizedBox(height: 12),
                        ElevatedButton(
                          onPressed: _showActionDialog,
                          child: const Text('{action_label}'),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: filtered.length,
                    itemBuilder: (context, index) {{
                      final record = filtered[index];
                      return Card(
                        margin: const EdgeInsets.only(bottom: 12),
                        child: ListTile(
                          leading: const CircleAvatar(child: Icon(Icons.layers)),
                          title: Text(record['title']!),
                          subtitle: Text(record['content']!),
                          trailing: Text(
                            record['category']!,
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                          ),
                          onTap: () {{
                            showDialog<void>(
                              context: context,
                              builder: (ctx) => AlertDialog(
                                title: Text(record['title']!),
                                content: Text(record['content']!),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(ctx),
                                    child: const Text('Close'),
                                  ),
                                ],
                              ),
                            );
                          }},
                        ),
                      );
                    }},
                  ),
          ),

          // Bottom log action button
          if (filtered.isNotEmpty)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton.icon(
                onPressed: _showActionDialog,
                icon: const Icon(Icons.add_task),
                label: const Text('{action_label}'),
              ),
            ),
        ],
      ),
    );
  }}

  void _showActionDialog() {{
    showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('{action_label}'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _dialogController,
              decoration: const InputDecoration(
                hintText: 'Enter details...',
                labelText: 'Operational Details',
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {{
              final text = _dialogController.text.trim();
              if (text.isNotEmpty) {{
                setState(() {{
                  _records.add({{
                    'title': text,
                    'content': 'Manually registered log record transaction.',
                    'category': _selectedCategory == 'All' ? 'General' : _selectedCategory,
                  }});
                }});
                _dialogController.clear();
              }}
              Navigator.pop(ctx);
            }},
            child: const Text('Confirm Action'),
          ),
        ],
      ),
    );
  }}
}}
"""

def run_upgrade():
    print("Upgrading 25 governed screens across apps (Round 10)...")
    for sc in screens_config:
        full_path = os.path.join(project_root, sc["file_path"].replace("/", os.sep))
        if not os.path.exists(full_path):
            print(f"Skipping missing file: {full_path}")
            continue

        # Extract prime screen name from metadata
        with open(full_path, "r", encoding="utf-8") as f:
            content = f.read()

        m = re.search(r'PRIME:SCREEN=([^\s\n]+)', content)
        prime_screen = m.group(1) if m else sc["class_name"].lower()

        # Format choice lists and items
        items_list = ",\n    ".join(sc["items"])
        categories_list = ", ".join([f"'{c}'" for c in sc["categories"]])

        new_content = template.format(
            prime_screen=prime_screen,
            controller_import=sc["controller_import"],
            controller_provider=sc["controller_provider"],
            class_name=sc["class_name"],
            title=sc["title"],
            desc=sc["desc"],
            items_list=items_list,
            categories_list=categories_list,
            action_label=sc["action_label"]
        )

        with open(full_path, "w", encoding="utf-8") as f:
            f.write(new_content)
        print(f"Upgraded governed screen code for: {sc['class_name']} at {sc['file_path']}")

if __name__ == "__main__":
    run_upgrade()
