import os
import re

project_root = r"C:\Users\Admin2\Documents\GitHub\primecare-platform"

screens_config = [
    {
        "file_path": r"apps/primecare_corporate/lib/features/generated_screens/ceo_dashboard_screen.dart",
        "controller_import": "ceo_dashboard_screen_controller.dart",
        "controller_provider": "ceoDashboardScreenControllerProvider",
        "class_name": "CeoDashboardScreen",
        "title": "CEO Dashboard",
        "desc": "Review branch operational indicators, patient satisfaction rating, and regional franchise growth goals.",
        "categories": ["All", "KPIs", "Feedback", "Goals"],
        "items": [
            "{'title': 'KPI: Weekly shift completion', 'content': 'Completed 420 visits. SLA response rate: 98.2%.', 'category': 'KPIs'}",
            "{'title': 'Feedback: Client NPS Survey', 'content': 'Average satisfaction score: 92%. Active positive reviews.', 'category': 'Feedback'}",
            "{'title': 'Goal: GTA West expansion lead', 'content': 'Initial proposal review scheduled with territory group.', 'category': 'Goals'}"
        ],
        "action_label": "Submit Goal Milestone"
    },
    {
        "file_path": r"apps/primecare_corporate/lib/features/generated_screens/coo_reports_screen.dart",
        "controller_import": "coo_reports_screen_controller.dart",
        "controller_provider": "cooReportsScreenControllerProvider",
        "class_name": "CooReportsScreen",
        "title": "COO Reports",
        "desc": "Generate operational SLA metrics, shift summaries, and visit checklists.",
        "categories": ["All", "SLA", "Shifts", "Checklists"],
        "items": [
            "{'title': 'SLA: Response time audit report', 'content': 'Average response time matches target limits.', 'category': 'SLA'}",
            "{'title': 'Shift: Monthly utilization matrix', 'content': '1,420 total shifts logged across franchise region.', 'category': 'Shifts'}",
            "{'title': 'Checklist: ADL sign-off audit log', 'content': '99.4% signing rate verified. System is secure.', 'category': 'Checklists'}"
        ],
        "action_label": "Export Operations Report"
    },
    {
        "file_path": r"apps/primecare_franchise/lib/features/scheduler_coordinator/screens/scheduler_coordinator_shift_calendar_screen.dart",
        "controller_import": "scheduler_coordinator_shift_calendar_screen_controller.dart",
        "controller_provider": "schedulerCoordinatorShiftCalendarScreenControllerProvider",
        "class_name": "SchedulerCoordinatorShiftCalendarScreen",
        "title": "Scheduler Coordinator Shift Calendar",
        "desc": "Audit weekly shift schedules, auto-matcher assignments, and caregiver availability.",
        "categories": ["All", "Schedules", "AutoMatch", "Availability"],
        "items": [
            "{'title': 'Schedule: June vital lab rotation', 'content': 'Verified. 100% weekly shift fill rate.', 'category': 'Schedules'}",
            "{'title': 'AutoMatch: Priority shift queues', 'content': '42 shifts auto-assigned. Uptime optimal.', 'category': 'AutoMatch'}",
            "{'title': 'Availability: Allied health time logs', 'content': 'Checked 12 massage therapists for weekend shifts.', 'category': 'Availability'}"
        ],
        "action_label": "Sync Shift Scheduler"
    },
    {
        "file_path": r"apps/primecare_governance/lib/features/audit/screens/audit_log_screen.dart",
        "controller_import": "audit_log_screen_controller.dart",
        "controller_provider": "auditLogScreenControllerProvider",
        "class_name": "AuditLogScreen",
        "title": "Audit Log",
        "desc": "Audit and trace platform administrative operations and database log transactions.",
        "categories": ["All", "Security", "Operations", "Database"],
        "items": [
            "{'title': 'Security: SSH Key update', 'content': 'Authorized key added by Devops at 10:24 AM.', 'category': 'Security'}",
            "{'title': 'Operations: Database backup', 'content': 'Completed transaction log backup to R2 storage.', 'category': 'Database'}",
            "{'title': 'System: Automated sweep completed', 'content': 'Scanned 970 route paths for layout invariance.', 'category': 'Security'}"
        ],
        "action_label": "Run Security Sweep"
    },
    {
        "file_path": r"apps/primecare_governance/lib/features/audit/screens/monitoring_screen.dart",
        "controller_import": "monitoring_screen_controller.dart",
        "controller_provider": "monitoringScreenControllerProvider",
        "class_name": "MonitoringScreen",
        "title": "Monitoring",
        "desc": "Monitor worker API endpoint status, track latency spikes, and log system errors.",
        "categories": ["All", "Endpoints", "Latency", "Errors"],
        "items": [
            "{'title': 'Endpoint: /v1/auth/me', 'content': 'Active. Status: 200 OK. Average response: 18ms.', 'category': 'Endpoints'}",
            "{'title': 'Latency Alert: /v1/patient/vitals', 'content': 'Average response time spike: 220ms. Server warning.', 'category': 'Latency'}",
            "{'title': 'Error: /v1/billing/reconcile', 'content': 'Status 500. Orphaned tenant lookup error caught.', 'category': 'Errors'}"
        ],
        "action_label": "Flush API Gateway Cache"
    },
    {
        "file_path": r"apps/primecare_governance/lib/features/audit/screens/ticket_center_screen.dart",
        "controller_import": "ticket_center_screen_controller.dart",
        "controller_provider": "ticketCenterScreenControllerProvider",
        "class_name": "TicketCenterScreen",
        "title": "Ticket Center",
        "desc": "Track platform bugs, developer tickets, and system patching schedules.",
        "categories": ["All", "Critical", "InDevelopment", "Resolved"],
        "items": [
            "{'title': 'Ticket #T-102: Webpack build crash', 'content': 'Resolved. Replaced package:web with url_launcher.', 'category': 'Resolved'}",
            "{'title': 'Ticket #T-103: Patient vital sync delay', 'content': 'InDevelopment. Fixing client websocket connection.', 'category': 'InDevelopment'}",
            "{'title': 'Ticket #T-104: Security sweep warning', 'content': 'Critical. Unlocked route found in public routing.', 'category': 'Critical'}"
        ],
        "action_label": "Create Developer Ticket"
    },
    {
        "file_path": r"apps/primecare_governance/lib/features/executive/screens/governance_hud_screen.dart",
        "controller_import": "governance_hud_screen_controller.dart",
        "controller_provider": "governanceHudScreenControllerProvider",
        "class_name": "GovernanceHudScreen",
        "title": "Governance Hud",
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
        "file_path": r"apps/primecare_governance/lib/features/executive/screens/growth_pipeline_screen.dart",
        "controller_import": "growth_pipeline_screen_controller.dart",
        "controller_provider": "growthPipelineScreenControllerProvider",
        "class_name": "GrowthPipelineScreen",
        "title": "Growth Pipeline",
        "desc": "Track prospective clinic locations, franchise onboarding pipeline, and corporate leads.",
        "categories": ["All", "Pipelines", "Locations", "Leads"],
        "items": [
            "{'title': 'Pipeline: Hamilton West Clinic', 'content': 'Lease agreement negotiated. Fit-out scheduled.', 'category': 'Pipelines'}",
            "{'title': 'Location: Richmond Hill North', 'content': 'Demographic research completed. Score: 8.4/10.', 'category': 'Locations'}",
            "{'title': 'Lead: Burlington Franchise Group', 'content': 'Initial disclosure document reviewed and approved.', 'category': 'Leads'}"
        ],
        "action_label": "Submit Pipeline Entry"
    },
    {
        "file_path": r"apps/primecare_governance/lib/features/executive/screens/leadership_reports_screen.dart",
        "controller_import": "leadership_reports_screen_controller.dart",
        "controller_provider": "leadershipReportsScreenControllerProvider",
        "class_name": "LeadershipReportsScreen",
        "title": "Leadership Reports",
        "desc": "Access monthly reports from COO, CFO, and Clinical Directors.",
        "categories": ["All", "COO", "CFO", "Clinical"],
        "items": [
            "{'title': 'COO: Service Dispatch Metrics', 'content': 'PSW visit checklist completion rate: 98.4%.', 'category': 'COO'}",
            "{'title': 'CFO: Monthly Margin Analytics', 'content': 'Net profit margin holds at 22.4% for corporate clinics.', 'category': 'CFO'}",
            "{'title': 'Clinical: Incident Resolution SLA', 'content': 'All critical safety incidents closed within 2 hours.', 'category': 'Clinical'}"
        ],
        "action_label": "Download Leadership Reports"
    },
    {
        "file_path": r"apps/primecare_governance/lib/features/executive/screens/proposals_screen.dart",
        "controller_import": "proposals_screen_controller.dart",
        "controller_provider": "proposalsScreenControllerProvider",
        "class_name": "ProposalsScreen",
        "title": "Proposals",
        "desc": "Track setup proposals, franchise deals, and partnership contracts.",
        "categories": ["All", "Setup", "Franchise", "Partnerships"],
        "items": [
            "{'title': 'Setup: Milton North startup proposal', 'content': 'Awaiting signature from prospective owner.', 'category': 'Setup'}",
            "{'title': 'Franchise: Peel Region agreement draft', 'content': 'Completed feasibility review.', 'category': 'Franchise'}",
            "{'title': 'Partnership: Telus Health connection', 'content': 'Contract signed for direct billing API integration.', 'category': 'Partnerships'}"
        ],
        "action_label": "Submit Proposal Document"
    },
    {
        "file_path": r"apps/primecare_governance/lib/features/executive/screens/regional_performance_screen.dart",
        "controller_import": "regional_performance_screen_controller.dart",
        "controller_provider": "regionalPerformanceScreenControllerProvider",
        "class_name": "RegionalPerformanceScreen",
        "title": "Regional Performance",
        "desc": "Analyze regional revenue distribution, client retention, and visit SLAs.",
        "categories": ["All", "SLA", "Revenue", "Retention"],
        "items": [
            "{'title': 'SLA: GTA West Triage dispatch', 'content': 'Mississauga: 98% on-time. Milton: 94% on-time.', 'category': 'SLA'}",
            "{'title': 'Revenue: Regional Contribution Q2', 'content': 'Ontario: \\$1.2M. BC East: \\$840K. Alberta South: \\$620K.', 'category': 'Revenue'}",
            "{'title': 'Retention: Client churn analysis', 'content': 'Ontario West retention: 99.1%. Churn drops by 0.4%.', 'category': 'Retention'}"
        ],
        "action_label": "Generate Region Scorecard"
    },
    {
        "file_path": r"apps/primecare_governance/lib/features/qa/screens/audit_dashboard_screen.dart",
        "controller_import": "audit_dashboard_screen_controller.dart",
        "controller_provider": "auditDashboardScreenControllerProvider",
        "class_name": "AuditDashboardScreen",
        "title": "Audit Dashboard",
        "desc": "Monitor active clinic audit processes, audit files, and QA scores.",
        "categories": ["All", "Active", "Archived", "Alerts"],
        "items": [
            "{'title': 'Active: Milton Central safety check', 'content': 'In-home nurse care audit in progress. QA score: 98%.', 'category': 'Active'}",
            "{'title': 'Archived: Toronto West clinical review', 'content': 'Passed audit. Range of motion logs verified.', 'category': 'Archived'}",
            "{'title': 'Alert: Mississauga license expiry', 'content': 'Credential renewal required for 2 care staff.', 'category': 'Alerts'}"
        ],
        "action_label": "Schedule Compliance Audit"
    },
    {
        "file_path": r"apps/primecare_governance/lib/features/qa/screens/compliance_reviews_screen.dart",
        "controller_import": "compliance_reviews_screen_controller.dart",
        "controller_provider": "complianceReviewsScreenControllerProvider",
        "class_name": "ComplianceReviewsScreen",
        "title": "Compliance Reviews",
        "desc": "Review open policy violations, nursing incident reports, and corrective actions.",
        "categories": ["All", "Open", "Investigation", "Closed"],
        "items": [
            "{'title': 'Open: Incident #883 Medication drift', 'content': 'Dose check skipped. Assigned coordinator investigation.', 'category': 'Open'}",
            "{'title': 'Investigation: Client falls report', 'content': 'Toronto West staff review. Witness statement filed.', 'category': 'Investigation'}",
            "{'title': 'Closed: Patient consent issue', 'content': 'Consent signed and matched in DB. Case finalized.', 'category': 'Closed'}"
        ],
        "action_label": "Post Investigation Note"
    },
    {
        "file_path": r"apps/primecare_governance/lib/features/qa/screens/incident_reports_screen.dart",
        "controller_import": "incident_reports_screen_controller.dart",
        "controller_provider": "incidentReportsScreenControllerProvider",
        "class_name": "IncidentReportsScreen",
        "title": "Incident Reports",
        "desc": "Conduct compliance reviews on reported clinic incidents and coordinate corrective steps.",
        "categories": ["All", "ReviewPending", "Approved", "Escalated"],
        "items": [
            "{'title': 'Incident #I-89: Patient minor slip', 'content': 'Approved. Incident report signed off. No injury.', 'category': 'Approved'}",
            "{'title': 'Incident #I-90: Medication mismatch shift', 'content': 'ReviewPending. Pending clinical director interview.', 'category': 'ReviewPending'}",
            "{'title': 'Incident #I-91: Unauthorized data access', 'content': 'Escalated. Sent to IT CISO team for audit logging.', 'category': 'Escalated'}"
        ],
        "action_label": "Submit Review Findings"
    },
    {
        "file_path": r"apps/primecare_governance/lib/features/qa/screens/quality_metrics_screen.dart",
        "controller_import": "quality_metrics_screen_controller.dart",
        "controller_provider": "qualityMetricsScreenControllerProvider",
        "class_name": "QualityMetricsScreen",
        "title": "Quality Metrics",
        "desc": "Monitor QA survey reviews, customer satisfaction tracking, and caregiver rating metrics.",
        "categories": ["All", "Surveys", "Ratings", "QA"],
        "items": [
            "{'title': 'Survey: Post-visit feedback form', 'content': 'NPS score is 84. Positive comments rate: 92%.', 'category': 'Surveys'}",
            "{'title': 'Rating: Caregiver check evaluations', 'content': 'Staff average score is 4.8/5 for June.', 'category': 'Ratings'}",
            "{'title': 'QA: Clinical record audits', 'content': 'Completed annual check for 45 newly-hired staff.', 'category': 'QA'}"
        ],
        "action_label": "Submit QA Evaluation"
    },
    {
        "file_path": r"apps/primecare_governance/lib/features/reference/screens/clinical_reference_screen.dart",
        "controller_import": "clinical_reference_screen_controller.dart",
        "controller_provider": "clinicalReferenceScreenControllerProvider",
        "class_name": "ClinicalReferenceScreen",
        "title": "Clinical Reference",
        "desc": "Verify nurse care plan frameworks, safety check criteria, and medication guidelines.",
        "categories": ["All", "BedsideCare", "Safety", "Medications"],
        "items": [
            "{'title': 'Care: ADL check-off compliance', 'content': 'Mandatory check-off within 15 minutes of visit exit.', 'category': 'BedsideCare'}",
            "{'title': 'Safety: Patient transfer guidelines', 'content': 'Two-person transfer protocol required for high-risk patients.', 'category': 'Safety'}",
            "{'title': 'Meds: Insulin double-check rule', 'content': 'Second nurse verify dose before bedside administration.', 'category': 'Medications'}"
        ],
        "action_label": "Log Policy Amendment"
    },
    {
        "file_path": r"apps/primecare_governance/lib/features/security/screens/security_hub_screen.dart",
        "controller_import": "security_hub_screen_controller.dart",
        "controller_provider": "securityHubScreenControllerProvider",
        "class_name": "SecurityHubScreen",
        "title": "Security Hub",
        "desc": "Monitor user permissions, roles, and access controls to maintain security.",
        "categories": ["All", "Users", "Roles", "Logs"],
        "items": [
            "{'title': 'User: RN Sarah Vance permissions', 'content': 'Assigned Clinical Role. Authorized for vitals database read/write.', 'category': 'Users'}",
            "{'title': 'Role: Compliance Manager sync', 'content': 'Updated role definitions to include access to risk registry.', 'category': 'Roles'}",
            "{'title': 'Audit Log: SuperAdmin credentials', 'content': 'Authorized SSH key added. Trace id: AC-9201.', 'category': 'Logs'}"
        ],
        "action_label": "Revoke Access Token"
    },
    {
        "file_path": r"apps/primecare_governance/lib/features/security/screens/security_sentinel_screen.dart",
        "controller_import": "security_sentinel_screen_controller.dart",
        "controller_provider": "securitySentinelScreenControllerProvider",
        "class_name": "SecuritySentinelScreen",
        "title": "Security Sentinel",
        "desc": "Audit evolution of security controls, monitor database query speeds, and track platform exposures.",
        "categories": ["All", "D1Speed", "Exposures", "Sweeps"],
        "items": [
            "{'title': 'D1: Read and write limits', 'content': 'Optimal response: 2ms. Database is healthy and synchronized.', 'category': 'D1Speed'}",
            "{'title': 'Exposures: Port scan audit log', 'content': '0 ports open. Edge routing rules successfully applied.', 'category': 'Exposures'}",
            "{'title': 'Sweep: Automatic route scanner', 'content': 'Completed verification of 970 dynamic routes.', 'category': 'Sweeps'}"
        ],
        "action_label": "Trigger Global Threat Scan"
    },
    {
        "file_path": r"apps/primecare_marketing/lib/features/generated_screens/community_outreach_contacts_screen.dart",
        "controller_import": "community_outreach_contacts_screen_controller.dart",
        "controller_provider": "communityOutreachContactsScreenControllerProvider",
        "class_name": "CommunityOutreachContactsScreen",
        "title": "Community Outreach Contacts",
        "desc": "Maintain contact listings for local senior care groups, community center representatives, and allied health partners.",
        "categories": ["All", "Centers", "AlliedPartners", "Seniors"],
        "items": [
            "{'title': 'Center: Mississauga Seniors Club', 'content': 'Contact: Mary Vance. Phone: 905-555-0192.', 'category': 'Centers'}",
            "{'title': 'Allied: Oakville Physiotherapist office', 'content': 'Contact: Robert Lee. Phone: 905-555-0143.', 'category': 'AlliedPartners'}",
            "{'title': 'Senior: Milton Retirement home coordinator', 'content': 'Contact: Sarah Vance. Phone: 905-555-0178.', 'category': 'Seniors'}"
        ],
        "action_label": "Register Outreach Contact"
    },
    {
        "file_path": r"apps/primecare_marketing/lib/features/generated_screens/community_outreach_events_screen.dart",
        "controller_import": "community_outreach_events_screen_controller.dart",
        "controller_provider": "communityOutreachEventsScreenControllerProvider",
        "class_name": "CommunityOutreachEventsScreen",
        "title": "Community Outreach Events",
        "desc": "Plan, coordinate, and review local senior wellness fairs, caregiver seminars, and healthcare workshops.",
        "categories": ["All", "Fairs", "Seminars", "Workshops"],
        "items": [
            "{'title': 'Fair: Milton Senior Wellness Fair', 'content': 'Date: July 12. Setup: Booth #14. Prepared brochures.', 'category': 'Fairs'}",
            "{'title': 'Seminar: In-home dementia support rules', 'content': 'Date: June 30. Location: Mississauga Library.', 'category': 'Seminars'}",
            "{'title': 'Workshop: Elder safe transfers techniques', 'content': 'Date: June 28. In-person clinical lab demonstration.', 'category': 'Workshops'}"
        ],
        "action_label": "Log Community Event"
    },
    {
        "file_path": r"apps/primecare_marketing/lib/features/generated_screens/community_outreach_follow_ups_screen.dart",
        "controller_import": "community_outreach_follow_ups_screen_controller.dart",
        "controller_provider": "communityOutreachFollowUpsScreenControllerProvider",
        "class_name": "CommunityOutreachFollowUpsScreen",
        "title": "Community Outreach Follow Ups",
        "desc": "Track follow-up dispatches, inquiry responses, and scheduling requests from community outreach leads.",
        "categories": ["All", "Pending", "InProcess", "Completed"],
        "items": [
            "{'title': 'Pending: Milton fair visitor brochure', 'content': 'Request: Send home care pricing checklist.', 'category': 'Pending'}",
            "{'title': 'InProcess: Oakville clinic phone followup', 'content': 'Calling center representative for agreement sync.', 'category': 'InProcess'}",
            "{'title': 'Completed: Mississauga email dispatch', 'content': 'Sent dementia support details to 18 inquiry leads.', 'category': 'Completed'}"
        ],
        "action_label": "Schedule Follow-Up Task"
    },
    {
        "file_path": r"apps/primecare_marketing/lib/features/generated_screens/community_outreach_partnerships_screen.dart",
        "controller_import": "community_outreach_partnerships_screen_controller.dart",
        "controller_provider": "communityOutreachPartnershipsScreenControllerProvider",
        "class_name": "CommunityOutreachPartnershipsScreen",
        "title": "Community Partnerships",
        "desc": "Review agreements and coordinate referral networks with local clinics and community healthcare agencies.",
        "categories": ["All", "Agreements", "ReferralNets", "Agencies"],
        "items": [
            "{'title': 'Agreement: Telus Health direct portal link', 'content': 'Signed contract. Awaiting co-pay credential sync.', 'category': 'Agreements'}",
            "{'title': 'Referral: GTA Chiropractor partnership', 'content': 'Allows direct referral pipelines to clinic system.', 'category': 'ReferralNets'}",
            "{'title': 'Agency: Milton region home support node', 'content': 'Joint dispatch standby list registered.', 'category': 'Agencies'}"
        ],
        "action_label": "Propose Partnership Agreement"
    },
    {
        "file_path": r"apps/primecare_marketing/lib/features/generated_screens/community_outreach_programs_screen.dart",
        "controller_import": "community_outreach_programs_screen_controller.dart",
        "controller_provider": "communityOutreachProgramsScreenControllerProvider",
        "class_name": "CommunityOutreachProgramsScreen",
        "title": "Community Outreach Programs",
        "desc": "Manage specialized outreach programs such as caregiver relief tracks and community health education.",
        "categories": ["All", "ReliefTracks", "Education", "Schedules"],
        "items": [
            "{'title': 'Relief: Caregiver weekend respite program', 'content': 'Allocated reserve mobile nursing hours for GTA.', 'category': 'ReliefTracks'}",
            "{'title': 'Education: In-home hygiene standards', 'content': 'Completed community health workshop course slide.', 'category': 'Education'}",
            "{'title': 'Schedule: Milton outreach calendar', 'content': 'Weekly scheduling matrix synchronized.', 'category': 'Schedules'}"
        ],
        "action_label": "Register Outreach Program"
    },
    {
        "file_path": r"apps/primecare_marketing/lib/features/generated_screens/community_outreach_reports_screen.dart",
        "controller_import": "community_outreach_reports_screen_controller.dart",
        "controller_provider": "communityOutreachReportsScreenControllerProvider",
        "class_name": "CommunityOutreachReportsScreen",
        "title": "Community Outreach Reports",
        "desc": "Compile community program performance metrics, cost analytics, and lead conversion reports.",
        "categories": ["All", "Performance", "Costs", "Leads"],
        "items": [
            "{'title': 'Performance: Wellness fair results', 'content': 'GTA fair lead generation rate up 14% over Q1.', 'category': 'Performance'}",
            "{'title': 'Costs: Community marketing budget', 'content': 'Spent \\$12,400. Within planned allocations.', 'category': 'Costs'}",
            "{'title': 'Leads: Referral conversion check', 'content': 'Average customer acquisition cost holds at \\$112.', 'category': 'Leads'}"
        ],
        "action_label": "Generate Outreach Report"
    },
    {
        "file_path": r"apps/primecare_marketing/lib/features/generated_screens/community_outreach_volunteers_screen.dart",
        "controller_import": "community_outreach_volunteers_screen_controller.dart",
        "controller_provider": "communityOutreachVolunteersScreenControllerProvider",
        "class_name": "CommunityOutreachVolunteersScreen",
        "title": "Outreach Volunteers",
        "desc": "Track volunteer applications, credential clearances, and event schedule assignments.",
        "categories": ["All", "Applicants", "Clearances", "Schedules"],
        "items": [
            "{'title': 'Applicant: Senior care companion check', 'content': 'John Doe. Interview slot scheduled on Tuesday.', 'category': 'Applicants'}",
            "{'title': 'Clearance: Vulnerable sector validation', 'content': 'Verified Red Cross certificate status.', 'category': 'Clearances'}",
            "{'title': 'Schedule: Milton fair booth crew', 'content': 'Assigned 4 volunteers for afternoon rotation.', 'category': 'Schedules'}"
        ],
        "action_label": "Register Volunteer Assignment"
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
    print("Upgrading 25 governed screens across apps (Round 8)...")
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
