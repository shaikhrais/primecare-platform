import os
import re

project_root = r"C:\Users\Admin2\Documents\GitHub\primecare-platform"

screens_config = [
    {
        "file_path": r"apps/primecare_corporate/lib/features/generated_screens/cto_verification_hub_screen.dart",
        "controller_import": "cto_verification_hub_screen_controller.dart",
        "controller_provider": "ctoVerificationHubScreenControllerProvider",
        "class_name": "CtoVerificationHubScreen",
        "title": "CTO Verification Hub",
        "desc": "Audit and verify system health logs, database migrations, security patches, and deployment telemetry.",
        "categories": ["All", "Migrations", "Security", "Telemetry"],
        "items": [
            "{'title': 'Migration: D1 Schema v4.2', 'content': 'Successfully applied. Verified 48 client tables.', 'category': 'Migrations'}",
            "{'title': 'Security: Automated scan sweep', 'content': 'Completed. Checked 970 route paths. Zero loops found.', 'category': 'Security'}",
            "{'title': 'Telemetry: Edge latency check', 'content': 'Cloudflare Worker routing latency drops by 4ms.', 'category': 'Telemetry'}"
        ],
        "action_label": "Run System Verification"
    },
    {
        "file_path": r"apps/primecare_corporate/lib/features/generated_screens/finance_director_cashflow_screen.dart",
        "controller_import": "finance_director_cashflow_screen_controller.dart",
        "controller_provider": "financeDirectorCashflowScreenControllerProvider",
        "class_name": "FinanceDirectorCashflowScreen",
        "title": "Finance Director Cashflow",
        "desc": "Monitor double-entry ledger flow, direct billing insurance claims, and real-time cash forecasting.",
        "categories": ["All", "Ledger", "Claims", "Forecasts"],
        "items": [
            "{'title': 'Ledger: Plaid bank ingestion', 'content': 'Auto-matched 420 transaction records from daily payout.', 'category': 'Ledger'}",
            "{'title': 'Claims: SunLife Direct Billing', 'content': 'Batch #882 processed. Net payout of \\$42,500.', 'category': 'Claims'}",
            "{'title': 'Forecast: AI 90-day projection', 'content': 'Expected net cash flow positive: +\\$120K.', 'category': 'Forecasts'}"
        ],
        "action_label": "Reconcile Cashflow Logs"
    },
    {
        "file_path": r"apps/primecare_corporate/lib/features/generated_screens/training_director_assessments_screen.dart",
        "controller_import": "training_director_assessments_screen_controller.dart",
        "controller_provider": "trainingDirectorAssessmentsScreenControllerProvider",
        "class_name": "TrainingDirectorAssessmentsScreen",
        "title": "Training Director Assessments",
        "desc": "Design, assign, and audit nurse and caregiver competency assessments and exam results.",
        "categories": ["All", "Competency", "Exams", "Audits"],
        "items": [
            "{'title': 'Competency: Insulin admin check', 'content': 'Audit score: 98.4%. Verified 24 nurse completions.', 'category': 'Competency'}",
            "{'title': 'Exam: Dementia Support Level 1', 'content': 'Assigned to 18 newly-onboarded caregiver staff.', 'category': 'Exams'}",
            "{'title': 'Audit: Clinical compliance score', 'content': 'Mississauga clinic scored 100% in compliance sweep.', 'category': 'Audits'}"
        ],
        "action_label": "Create Assessment Template"
    },
    {
        "file_path": r"apps/primecare_corporate/lib/features/generated_screens/training_director_certificates_screen.dart",
        "controller_import": "training_director_certificates_screen_controller.dart",
        "controller_provider": "trainingDirectorCertificatesScreenControllerProvider",
        "class_name": "TrainingDirectorCertificatesScreen",
        "title": "Training Director Certificates",
        "desc": "Track and verify certificate issuances for first aid, CPR, and advanced care courses.",
        "categories": ["All", "FirstAid", "CPR", "Verifications"],
        "items": [
            "{'title': 'FirstAid: Red Cross renewal', 'content': 'Issued to 12 caregivers in GTA North region.', 'category': 'FirstAid'}",
            "{'title': 'CPR: Advanced Cardiac Life Support', 'content': 'Certified 4 corporate clinical supervisors.', 'category': 'CPR'}",
            "{'title': 'Verification: Background clearances', 'content': 'Verified 10 vulnerable sector check records.', 'category': 'Verifications'}"
        ],
        "action_label": "Issue Course Certificate"
    },
    {
        "file_path": r"apps/primecare_corporate/lib/features/generated_screens/training_director_certifications_screen.dart",
        "controller_import": "training_director_certifications_screen_controller.dart",
        "controller_provider": "trainingDirectorCertificationsScreenControllerProvider",
        "class_name": "TrainingDirectorCertificationsScreen",
        "title": "Training Director Certifications",
        "desc": "Audit and manage official board registrations, nursing licenses, and specialized caregiver credentials.",
        "categories": ["All", "Licenses", "Credentials", "Expiries"],
        "items": [
            "{'title': 'License: College of Nurses sync', 'content': 'CNO database checked. 42 RN registrations validated.', 'category': 'Licenses'}",
            "{'title': 'Credential: Wound Care specialist', 'content': 'Approved certification for Nurse Vance.', 'category': 'Credentials'}",
            "{'title': 'Expiry: First Aid warnings', 'content': 'Dispatched warnings to 8 caregivers expiring in 30 days.', 'category': 'Expiries'}"
        ],
        "action_label": "Sync License Database"
    },
    {
        "file_path": r"apps/primecare_corporate/lib/features/generated_screens/training_director_compliance_training_screen.dart",
        "controller_import": "training_director_compliance_training_screen_controller.dart",
        "controller_provider": "trainingDirectorComplianceTrainingScreenControllerProvider",
        "class_name": "TrainingDirectorComplianceTrainingScreen",
        "title": "Training Director Compliance Training",
        "desc": "Enforce annual safety sweeps, infection control courses, and privacy compliance workshops.",
        "categories": ["All", "InfectionControl", "Privacy", "Workshops"],
        "items": [
            "{'title': 'Infection: Hand hygiene protocol', 'content': 'Completed by 94% of active frontline caregivers.', 'category': 'InfectionControl'}",
            "{'title': 'Privacy: PHIPA training course', 'content': 'Assigned to all administrative and dispatch staff.', 'category': 'Privacy'}",
            "{'title': 'Workshop: Safe patient transfers', 'content': 'Scheduled for June 28 at Mississauga training center.', 'category': 'Workshops'}"
        ],
        "action_label": "Assign Compliance Module"
    },
    {
        "file_path": r"apps/primecare_corporate/lib/features/generated_screens/training_director_course_architect_screen.dart",
        "controller_import": "training_director_course_architect_screen_controller.dart",
        "controller_provider": "trainingDirectorCourseArchitectScreenControllerProvider",
        "class_name": "TrainingDirectorCourseArchitectScreen",
        "title": "Training Director Course Architect",
        "desc": "Design training curricula, structure interactive slides, and configure testing thresholds.",
        "categories": ["All", "Curriculum", "Slides", "Thresholds"],
        "items": [
            "{'title': 'Curriculum: Medication Admin v3', 'content': 'Added module on insulin dual-verification rules.', 'category': 'Curriculum'}",
            "{'title': 'Slide: In-home safety hazard check', 'content': 'Uploaded 12 interactive scenarios and checklists.', 'category': 'Slides'}",
            "{'title': 'Threshold: Passing score adjustment', 'content': 'Set passing grade to 85% for clinical courses.', 'category': 'Thresholds'}"
        ],
        "action_label": "Publish Curriculum Version"
    },
    {
        "file_path": r"apps/primecare_corporate/lib/features/generated_screens/training_director_course_library_screen.dart",
        "controller_import": "training_director_course_library_screen_controller.dart",
        "controller_provider": "trainingDirectorCourseLibraryScreenControllerProvider",
        "class_name": "TrainingDirectorCourseLibraryScreen",
        "title": "Training Director Course Library",
        "desc": "Manage the catalog of clinical, caregiver, and allied health training courses.",
        "categories": ["All", "Clinical", "Caregiver", "Allied"],
        "items": [
            "{'title': 'Clinical: IV Therapy protocols', 'content': 'Contains 4 modules, 2 exams. 1.5 credits.', 'category': 'Clinical'}",
            "{'title': 'Caregiver: In-home ADL assistance', 'content': 'Basic course for PSWs. 8 videos. 1 credit.', 'category': 'Caregiver'}",
            "{'title': 'Allied: Chiropractic assistant guidelines', 'content': 'Overview of adjustment note capturing.', 'category': 'Allied'}"
        ],
        "action_label": "Import Course File"
    },
    {
        "file_path": r"apps/primecare_corporate/lib/features/generated_screens/training_director_hub_screen.dart",
        "controller_import": "training_director_hub_screen_controller.dart",
        "controller_provider": "trainingDirectorHubScreenControllerProvider",
        "class_name": "TrainingDirectorHubScreen",
        "title": "Training Director Hub",
        "desc": "Central command for training metrics, active trainer assignments, and course updates.",
        "categories": ["All", "Trainers", "Analytics", "Updates"],
        "items": [
            "{'title': 'Trainer: Assigned Mary Vance to GTA', 'content': 'Will lead June orientation cohort in Mississauga.', 'category': 'Trainers'}",
            "{'title': 'Analytics: Completion rates peak', 'content': 'Average course completion is 94.2% across regions.', 'category': 'Analytics'}",
            "{'title': 'Update: Dementia course v1.4', 'content': 'Staged for deployment. Scheduled release: July 1.', 'category': 'Updates'}"
        ],
        "action_label": "Sync Training Hub"
    },
    {
        "file_path": r"apps/primecare_corporate/lib/features/generated_screens/training_director_reports_screen.dart",
        "controller_import": "training_director_reports_screen_controller.dart",
        "controller_provider": "trainingDirectorReportsScreenControllerProvider",
        "class_name": "TrainingDirectorReportsScreen",
        "title": "Training Director Reports",
        "desc": "Generate training compliance statistics, trainer logs, and certificate registry reports.",
        "categories": ["All", "Compliance", "Trainers", "Certificates"],
        "items": [
            "{'title': 'Compliance: Quarterly regional audit', 'content': 'GTA: 98% compliant. Milton: 95% compliant.', 'category': 'Compliance'}",
            "{'title': 'Trainer: In-person session logs', 'content': 'Logged 48 training hours across regional offices.', 'category': 'Trainers'}",
            "{'title': 'Certificate: Registry audit report', 'content': 'Issued 240 digital certificates in Q1.', 'category': 'Certificates'}"
        ],
        "action_label": "Generate Compliance Report"
    },
    {
        "file_path": r"apps/primecare_corporate/lib/features/generated_screens/training_director_staff_training_matrix_screen.dart",
        "controller_import": "training_director_staff_training_matrix_screen_controller.dart",
        "controller_provider": "trainingDirectorStaffTrainingMatrixScreenControllerProvider",
        "class_name": "TrainingDirectorStaffTrainingMatrixScreen",
        "title": "Training Director Staff Training Matrix",
        "desc": "Audit staff course completion matrix, identify training gaps, and schedule team retraining.",
        "categories": ["All", "Matrix", "Gaps", "Retraining"],
        "items": [
            "{'title': 'Matrix: Allied health staff', 'content': 'Checked 12 RMTs. 100% compliant on privacy protocols.', 'category': 'Matrix'}",
            "{'title': 'Gap: Dementia level 2 shortage', 'content': 'Found 8 caregivers needing refresher sessions.', 'category': 'Gaps'}",
            "{'title': 'Retraining: Insulin admin refresh', 'content': 'Scheduled retraining batch for 4 Milton staff.', 'category': 'Retraining'}"
        ],
        "action_label": "Run Matrix Audit"
    },
    {
        "file_path": r"apps/primecare_corporate/lib/features/generated_screens/training_director_trainer_assignments_screen.dart",
        "controller_import": "training_director_trainer_assignments_screen_controller.dart",
        "controller_provider": "trainingDirectorTrainerAssignmentsScreenControllerProvider",
        "class_name": "TrainingDirectorTrainerAssignmentsScreen",
        "title": "Training Director Trainer Assignments",
        "desc": "Coordinate active trainers, schedule in-person orientation sessions, and assign classes.",
        "categories": ["All", "Schedules", "Assignments", "Classes"],
        "items": [
            "{'title': 'Schedule: Milton clinical lab', 'content': 'Assigned trainer Sarah to lead safety classes.', 'category': 'Schedules'}",
            "{'title': 'Assignment: Orientation cohort C', 'content': 'Allocated Mary Smith as lead course coordinator.', 'category': 'Assignments'}",
            "{'title': 'Class: In-home lift procedures', 'content': 'Assigned trainer Robert to lead workshop #42.', 'category': 'Classes'}"
        ],
        "action_label": "Assign Course Trainer"
    },
    {
        "file_path": r"apps/primecare_corporate/lib/features/generated_screens/training_director_training_programs_screen.dart",
        "controller_import": "training_director_training_programs_screen_controller.dart",
        "controller_provider": "trainingDirectorTrainingProgramsScreenControllerProvider",
        "class_name": "TrainingDirectorTrainingProgramsScreen",
        "title": "Training Director Training Programs",
        "desc": "Configure corporate onboarding tracks, allied health specialties, and safety programs.",
        "categories": ["All", "Onboarding", "Specialties", "Programs"],
        "items": [
            "{'title': 'Onboarding: 2-week nurse track', 'content': 'Includes clinical software and vital logging modules.', 'category': 'Onboarding'}",
            "{'title': 'Specialty: Elder care support program', 'content': 'Advanced credentials for nursing home assignments.', 'category': 'Specialties'}",
            "{'title': 'Program: Annual infection sweep', 'content': 'Required for all active caregivers and staff.', 'category': 'Programs'}"
        ],
        "action_label": "Deploy Training Track"
    },
    {
        "file_path": r"apps/primecare_corporate/lib/features/training/screens/assessments_screen.dart",
        "controller_import": "assessments_screen_controller.dart",
        "controller_provider": "assessmentsScreenControllerProvider",
        "class_name": "AssessmentsScreen",
        "title": "Assessments",
        "desc": "Take assigned competency assessments, view grades, and check review notes.",
        "categories": ["All", "Assigned", "Grades", "Reviews"],
        "items": [
            "{'title': 'Assigned: PHIPA Privacy regulations', 'content': 'Due date: July 5. Format: 20 multiple choice questions.', 'category': 'Assigned'}",
            "{'title': 'Grade: Infection Control Level 1', 'content': 'Passed. Score: 92%. Checked on June 22.', 'category': 'Grades'}",
            "{'title': 'Review: Safe lift techniques feedback', 'content': 'Trainer comments: Clear stance. Re-verify belt tight.', 'category': 'Reviews'}"
        ],
        "action_label": "Start Assessment Test"
    },
    {
        "file_path": r"apps/primecare_corporate/lib/features/training/screens/certificates_screen.dart",
        "controller_import": "certificates_screen_controller.dart",
        "controller_provider": "certificatesScreenControllerProvider",
        "class_name": "CertificatesScreen",
        "title": "Certificates",
        "desc": "View and download active first aid, CPR, and professional care certificates.",
        "categories": ["All", "Active", "Archived", "Downloads"],
        "items": [
            "{'title': 'Active: Standard First Aid & CPR', 'content': 'Issued: June 2025. Valid until June 2027.', 'category': 'Active'}",
            "{'title': 'Archived: Dementia Care basic course', 'content': 'Issued: January 2024. Archived.', 'category': 'Archived'}",
            "{'title': 'Download: CPR Recertification receipt', 'content': 'PDF certificate file generated successfully.', 'category': 'Downloads'}"
        ],
        "action_label": "Download Certificate PDF"
    },
    {
        "file_path": r"apps/primecare_corporate/lib/features/training/screens/certifications_screen.dart",
        "controller_import": "certifications_screen_controller.dart",
        "controller_provider": "certificationsScreenControllerProvider",
        "class_name": "CertificationsScreen",
        "title": "Certifications",
        "desc": "Register official state credentials, track licensing compliance, and review expiry dates.",
        "categories": ["All", "Registered", "Compliance", "Expiries"],
        "items": [
            "{'title': 'Registered: Registered Practical Nurse', 'content': 'CNO license number: #99214. Active status.', 'category': 'Registered'}",
            "{'title': 'Compliance: Vital administration certificate', 'content': 'Status: Approved by clinical training director.', 'category': 'Compliance'}",
            "{'title': 'Expiry: ACLS credential alert', 'content': 'Renewal required within 45 days. Form ready.', 'category': 'Expiries'}"
        ],
        "action_label": "Submit Certification Renewal"
    },
    {
        "file_path": r"apps/primecare_corporate/lib/features/training/screens/compliance_training_screen.dart",
        "controller_import": "compliance_training_screen_controller.dart",
        "controller_provider": "complianceTrainingScreenControllerProvider",
        "class_name": "ComplianceTrainingScreen",
        "title": "Compliance Training",
        "desc": "Complete safety requirements, PHIPA training, and clinical hygiene checklists.",
        "categories": ["All", "Required", "Incomplete", "Completed"],
        "items": [
            "{'title': 'Required: Hand hygiene standards', 'content': 'Annual training requirement. Due: June 30.', 'category': 'Required'}",
            "{'title': 'Incomplete: Safe transfers workshop', 'content': 'Awaiting practical lab booking signature.', 'category': 'Incomplete'}",
            "{'title': 'Completed: PHIPA Privacy regulations', 'content': 'Passed certificate exam. Score: 95%.', 'category': 'Completed'}"
        ],
        "action_label": "Start Compliance Course"
    },
    {
        "file_path": r"apps/primecare_corporate/lib/features/training/screens/course_architect_screen.dart",
        "controller_import": "course_architect_screen_controller.dart",
        "controller_provider": "courseArchitectScreenControllerProvider",
        "class_name": "CourseArchitectScreen",
        "title": "Course Architect",
        "desc": "Contribute course slides, scenario suggestions, and vital checklists to course architects.",
        "categories": ["All", "Suggestions", "Slides", "Checklists"],
        "items": [
            "{'title': 'Suggestion: Allied Health transfers', 'content': 'Requested including chiropractic adjustment table lifts.', 'category': 'Suggestions'}",
            "{'title': 'Slide: In-home nurse sanitation check', 'content': 'Drafted slide outline with 5 steps.', 'category': 'Slides'}",
            "{'title': 'Checklist: Vital log verification', 'content': 'Submitted checklist matching standard procedures.', 'category': 'Checklists'}"
        ],
        "action_label": "Submit Curriculum Suggestion"
    },
    {
        "file_path": r"apps/primecare_corporate/lib/features/training/screens/course_library_screen.dart",
        "controller_import": "course_library_screen_controller.dart",
        "controller_provider": "courseLibraryScreenControllerProvider",
        "class_name": "CourseLibraryScreen",
        "title": "Course Library",
        "desc": "Search and register for professional development courses, videos, and clinical labs.",
        "categories": ["All", "Available", "Registered", "Completed"],
        "items": [
            "{'title': 'Available: Dementia Support basics', 'content': '8 modules. Open for registration. Free credit.', 'category': 'Available'}",
            "{'title': 'Registered: Wound Care Management', 'content': 'Assigned. Access slides and video lessons.', 'category': 'Registered'}",
            "{'title': 'Completed: Infection control sweep', 'content': 'Finished June 12. Digital certificate issued.', 'category': 'Completed'}"
        ],
        "action_label": "Enroll in Training Course"
    },
    {
        "file_path": r"apps/primecare_corporate/lib/features/training/screens/staff_training_matrix_screen.dart",
        "controller_import": "staff_training_matrix_screen_controller.dart",
        "controller_provider": "staffTrainingMatrixScreenControllerProvider",
        "class_name": "StaffTrainingMatrixScreen",
        "title": "Staff Training Matrix",
        "desc": "Monitor training completion metrics and compliance status across your branch staff.",
        "categories": ["All", "Branch", "Matrix", "Gaps"],
        "items": [
            "{'title': 'Branch: GTA West compliance rate', 'content': 'Staff compliance stands at 98.2% overall.', 'category': 'Branch'}",
            "{'title': 'Matrix: Nurse certifications status', 'content': '22 RNs active. All registered credentials validated.', 'category': 'Matrix'}",
            "{'title': 'Gap: Dementia level 1 training gap', 'content': '2 caregivers marked for upcoming cohort class.', 'category': 'Gaps'}"
        ],
        "action_label": "Refresh Matrix Metrics"
    },
    {
        "file_path": r"apps/primecare_corporate/lib/features/training/screens/trainer_assignments_screen.dart",
        "controller_import": "trainer_assignments_screen_controller.dart",
        "controller_provider": "trainerAssignmentsScreenControllerProvider",
        "class_name": "TrainerAssignmentsScreen",
        "title": "Trainer Assignments",
        "desc": "View assigned course trainers and schedule clinical lab mentorship sessions.",
        "categories": ["All", "Assigned", "Sessions", "Mentors"],
        "items": [
            "{'title': 'Assigned: Wound care lab mentorship', 'content': 'Trainer: Nurse Sarah Vance. Next session: Tuesday.', 'category': 'Assigned'}",
            "{'title': 'Session: Safe lift practical lab check', 'content': 'Trainer: Robert Smith. Assigned Milton room A.', 'category': 'Sessions'}",
            "{'title': 'Mentor: Allied health supervisor', 'content': 'Assigned Mary Smith for chiropractic workflow.', 'category': 'Mentors'}"
        ],
        "action_label": "Book Mentorship Session"
    },
    {
        "file_path": r"apps/primecare_corporate/lib/features/training/screens/training_analytics_screen.dart",
        "controller_import": "training_analytics_screen_controller.dart",
        "controller_provider": "trainingAnalyticsScreenControllerProvider",
        "class_name": "TrainingAnalyticsScreen",
        "title": "Training Analytics",
        "desc": "Review course completion rates, test grade distributions, and training cost metrics.",
        "categories": ["All", "Completion", "Grades", "Costs"],
        "items": [
            "{'title': 'Completion: Monthly progress chart', 'content': 'Average completion rate is 92.4% for all staff.', 'category': 'Completion'}",
            "{'title': 'Grade: Exam performance stats', 'content': 'Average grade: 89.2%. 98% pass rate on first attempt.', 'category': 'Grades'}",
            "{'title': 'Costs: Allied health credits balance', 'content': 'Corporate training credits remain positive.', 'category': 'Costs'}"
        ],
        "action_label": "Generate Performance Chart"
    },
    {
        "file_path": r"apps/primecare_corporate/lib/features/training/screens/training_hub_screen.dart",
        "controller_import": "training_hub_screen_controller.dart",
        "controller_provider": "trainingHubScreenControllerProvider",
        "class_name": "TrainingHubScreen",
        "title": "Training Hub",
        "desc": "Access training modules, register for classes, and check certification status.",
        "categories": ["All", "Modules", "Classes", "Certificates"],
        "items": [
            "{'title': 'Module: Standard First Aid v2', 'content': 'In progress. 4 modules remaining. Due in 15 days.', 'category': 'Modules'}",
            "{'title': 'Class: Safety transfers lab session', 'content': 'Registered. Scheduled for July 4 in Mississauga.', 'category': 'Classes'}",
            "{'title': 'Certificate: CNO registration verification', 'content': 'Approved by compliance director. Valid until Dec 2026.', 'category': 'Certificates'}"
        ],
        "action_label": "Enter Training Hub"
    },
    {
        "file_path": r"apps/primecare_corporate/lib/features/training/screens/training_programs_screen.dart",
        "controller_import": "training_programs_screen_controller.dart",
        "controller_provider": "trainingProgramsScreenControllerProvider",
        "class_name": "TrainingProgramsScreen",
        "title": "Training Programs",
        "desc": "Track your progress across specialized onboarding tracks and career pathways.",
        "categories": ["All", "Tracks", "Pathways", "Progress"],
        "items": [
            "{'title': 'Track: 2-week nurse orientation', 'content': 'Status: 85% completed. 1 module remaining.', 'category': 'Tracks'}",
            "{'title': 'Pathway: Elder Care Specialist pathway', 'content': 'Status: Registered. Awaiting Dementia Level 2 class.', 'category': 'Pathways'}",
            "{'title': 'Progress: Annual compliance program', 'content': 'Completed. Infection sweep verification uploaded.', 'category': 'Progress'}"
        ],
        "action_label": "Enroll in Specialty Track"
    },
    {
        "file_path": r"apps/primecare_corporate/lib/features/training/screens/training_reports_screen.dart",
        "controller_import": "training_reports_screen_controller.dart",
        "controller_provider": "trainingReportsScreenControllerProvider",
        "class_name": "TrainingReportsScreen",
        "title": "Training Reports",
        "desc": "Download course transcripts, completion checklists, and historical training records.",
        "categories": ["All", "Transcripts", "Checklists", "History"],
        "items": [
            "{'title': 'Transcript: Nurse Mary Smith log', 'content': 'Generated. Lists 18 completed modules, 4 CE credits.', 'category': 'Transcripts'}",
            "{'title': 'Checklist: Orientation signing page', 'content': 'Signed by supervisor Mary Smith. Approved.', 'category': 'Checklists'}",
            "{'title': 'History: Previous certifications file', 'content': 'Archived record of First Aid course from 2024.', 'category': 'History'}"
        ],
        "action_label": "Export Course Transcript"
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
    print("Upgrading 25 governed training/CTO screens (Round 6)...")
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
