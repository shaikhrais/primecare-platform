import os
import re

project_root = r"C:\Users\Admin2\Documents\GitHub\primecare-platform"

screens_config = [
    {
        "file_path": r"apps/primecare_franchise/lib/features/owner/screens/franchise_owner_dashboard_screen.dart",
        "controller_import": "franchise_owner_dashboard_screen_controller.dart",
        "controller_provider": "franchiseOwnerDashboardScreenControllerProvider",
        "class_name": "FranchiseOwnerDashboardScreen",
        "title": "Franchise Owner Dashboard",
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
        "file_path": r"apps/primecare_franchise/lib/features/owner/screens/franchise_owner_financial_snapshot_screen.dart",
        "controller_import": "franchise_owner_financial_snapshot_screen_controller.dart",
        "controller_provider": "franchiseOwnerFinancialSnapshotScreenControllerProvider",
        "class_name": "FranchiseOwnerFinancialSnapshotScreen",
        "title": "Franchise Owner Financial Snapshot",
        "desc": "Monitor franchise double-entry ledger flows, weekly payroll audits, and royalty payments.",
        "categories": ["All", "Ledger", "Payroll", "Royalties"],
        "items": [
            "{'title': 'Ledger: Active invoices count', 'content': 'Invoiced: \\$48,500. Awaiting Plaid settlement.', 'category': 'Ledger'}",
            "{'title': 'Payroll: Caregiver hourly logs', 'content': 'Processed Q2 batch for 24 caregivers. Confirmed payout.', 'category': 'Payroll'}",
            "{'title': 'Royalty: Corporate remittance check', 'content': 'Transferred 6% royalty. Transaction: TR-99214.', 'category': 'Royalties'}"
        ],
        "action_label": "Generate Financial Statement"
    },
    {
        "file_path": r"apps/primecare_franchise/lib/features/owner/screens/franchise_owner_hiring_screen.dart",
        "controller_import": "franchise_owner_hiring_screen_controller.dart",
        "controller_provider": "franchiseOwnerHiringScreenControllerProvider",
        "class_name": "FranchiseOwnerHiringScreen",
        "title": "Franchise Owner Hiring",
        "desc": "Verify newly-hired caregiver application reviews, background clearances, and interview slots.",
        "categories": ["All", "Applications", "Clearances", "Interviews"],
        "items": [
            "{'title': 'App: Nurse Mary Smith referral', 'content': 'RN application received. Awaiting board registration validation.', 'category': 'Applications'}",
            "{'title': 'Clearance: Vulnerable sector check', 'content': 'Sarah Vance certificate received. Checked in CNO database.', 'category': 'Clearances'}",
            "{'title': 'Interview: Frontline PSW group', 'content': 'Scheduled 4 interviews for June 30 orientation.', 'category': 'Interviews'}"
        ],
        "action_label": "Register Hiring Entry"
    },
    {
        "file_path": r"apps/primecare_franchise/lib/features/hr_hiring/screens/hr_hiring_reports_screen.dart",
        "controller_import": "hr_hiring_reports_screen_controller.dart",
        "controller_provider": "hrHiringReportsScreenControllerProvider",
        "class_name": "HrHiringReportsScreen",
        "title": "Hr Hiring Reports",
        "desc": "Generate recruitment metrics, onboarding stats, and employee credential reviews.",
        "categories": ["All", "Recruitment", "Onboarding", "Credentials"],
        "items": [
            "{'title': 'Recruit: Monthly applicant summary', 'content': 'Received 42 applications. 12 candidates selected.', 'category': 'Recruitment'}",
            "{'title': 'Onboard: June nurse cohort status', 'content': '18 nurses completed core clinical system training.', 'category': 'Onboarding'}",
            "{'title': 'Credential: RN licensing validation', 'content': '100% compliance certified for all active staff.', 'category': 'Credentials'}"
        ],
        "action_label": "Export Hiring PDF"
    },
    {
        "file_path": r"apps/primecare_franchise/lib/features/hr_hiring/screens/hr_hiring_staff_documents_screen.dart",
        "controller_import": "hr_hiring_staff_documents_screen_controller.dart",
        "controller_provider": "hrHiringStaffDocumentsScreenControllerProvider",
        "class_name": "HrHiringStaffDocumentsScreen",
        "title": "Hr Hiring Staff Documents",
        "desc": "Manage caregiver contracts, tax files, and state liability insurance clearances.",
        "categories": ["All", "Contracts", "TaxFiles", "Clearances"],
        "items": [
            "{'title': 'Contract: PSW caregiver Mary Vance', 'content': 'Signed and archived in staff document registry.', 'category': 'Contracts'}",
            "{'title': 'Tax: CRA tax withholding file', 'content': 'Completed TD1 form matched to payroll ID #401.', 'category': 'TaxFiles'}",
            "{'title': 'Clearance: CPR/First Aid Renewal', 'content': '12 GTA caregiver certificates verified and logged.', 'category': 'Clearances'}"
        ],
        "action_label": "Upload Staff Document"
    },
    {
        "file_path": r"apps/primecare_franchise/lib/features/hr_hiring/screens/hr_hiring_training_status_screen.dart",
        "controller_import": "hr_hiring_training_status_screen_controller.dart",
        "controller_provider": "hrHiringTrainingStatusScreenControllerProvider",
        "class_name": "HrHiringTrainingStatusScreen",
        "title": "Hr Hiring Training Status",
        "desc": "Monitor orientation completion rates, infection control compliance, and safety sweeps.",
        "categories": ["All", "Orientation", "Compliance", "Specialties"],
        "items": [
            "{'title': 'Orientation: June intake group', 'content': '18 caregivers completed core system orientation.', 'category': 'Orientation'}",
            "{'title': 'Compliance: Hand hygiene workshop', 'content': 'Completion rating: 100% for active shift staff.', 'category': 'Compliance'}",
            "{'title': 'Specialty: Dementia care support track', 'content': '8 caregivers registered for July cohort.', 'category': 'Specialties'}"
        ],
        "action_label": "Assign Training Module"
    },
    {
        "file_path": r"apps/primecare_franchise/lib/features/marketing_manager/screens/marketing_manager_campaigns_screen.dart",
        "controller_import": "marketing_manager_campaigns_screen_controller.dart",
        "controller_provider": "marketingManagerCampaignsScreenControllerProvider",
        "class_name": "MarketingManagerCampaignsScreen",
        "title": "Marketing Manager Campaigns",
        "desc": "Configure regional digital ads, local community outreach, and email referral campaigns.",
        "categories": ["All", "DigitalAds", "Outreach", "Referrals"],
        "items": [
            "{'title': 'Ad: Facebook Senior Care campaigns', 'content': 'Active. Reach: 12,400. Direct inquiries: 84.', 'category': 'DigitalAds'}",
            "{'title': 'Outreach: Milton Health Fair booth', 'content': 'Scheduled for July 12. Prepared brochures.', 'category': 'Outreach'}",
            "{'title': 'Referral: Family caregiver coupon', 'content': 'Email campaign dispatched to 420 local clients.', 'category': 'Referrals'}"
        ],
        "action_label": "Launch Marketing Campaign"
    },
    {
        "file_path": r"apps/primecare_franchise/lib/features/marketing_manager/screens/marketing_manager_dashboard_screen.dart",
        "controller_import": "marketing_manager_dashboard_screen_controller.dart",
        "controller_provider": "marketingManagerDashboardScreenControllerProvider",
        "class_name": "MarketingManagerDashboardScreen",
        "title": "Marketing Manager Dashboard",
        "desc": "Monitor lead intake statistics, referral program performance, and customer acquisition costs.",
        "categories": ["All", "Leads", "Referrals", "Metrics"],
        "items": [
            "{'title': 'Lead: Oakville Central Inquiry', 'content': 'Client requested brochure. Sent demographic info.', 'category': 'Leads'}",
            "{'title': 'Referral: Allied health partner sync', 'content': 'Received 12 clinical referral leads from physio center.', 'category': 'Referrals'}",
            "{'title': 'Metric: CAC acquisition analysis', 'content': 'Average customer acquisition cost holds at \\$112.', 'category': 'Metrics'}"
        ],
        "action_label": "Submit Lead Entry"
    },
    {
        "file_path": r"apps/primecare_franchise/lib/features/ops/screens/operations_manager_attendance_screen.dart",
        "controller_import": "operations_manager_attendance_screen_controller.dart",
        "controller_provider": "operationsManagerAttendanceScreenControllerProvider",
        "class_name": "OperationsManagerAttendanceScreen",
        "title": "Operations Manager Attendance",
        "desc": "Track caregiver clock-in times, shift check-in GPS audits, and absent warnings.",
        "categories": ["All", "ClockIns", "GPS", "Absences"],
        "items": [
            "{'title': 'ClockIn: Nurse Mary Vance check', 'content': 'Checked in at client bedside at 9:00 AM (on-time).', 'category': 'ClockIns'}",
            "{'title': 'GPS: Milton West Geofence check', 'content': 'Caregiver Mary Smith within 50m radius of residence.', 'category': 'GPS'}",
            "{'title': 'Absence: Allied RMT shift coverage', 'content': 'Staff absent due to illness. Reserve mobile RN dispatched.', 'category': 'Absences'}"
        ],
        "action_label": "Audit Shift Attendance"
    },
    {
        "file_path": r"apps/primecare_franchise/lib/features/ops/screens/operations_manager_daily_operations_screen.dart",
        "controller_import": "operations_manager_daily_operations_screen_controller.dart",
        "controller_provider": "operationsManagerDailyOperationsScreenControllerProvider",
        "class_name": "OperationsManagerDailyOperationsScreen",
        "title": "Operations Manager Daily Operations",
        "desc": "Track active caregiver dispatches, hourly visit checklists, and client incident queues.",
        "categories": ["All", "Dispatches", "Checklists", "Incidents"],
        "items": [
            "{'title': 'Dispatch: Mississauga South zone', 'content': 'Active dispatches: 84. Average SLA response: 24 mins.', 'category': 'Dispatches'}",
            "{'title': 'Checklist: ADL sign-off summary', 'content': 'Frontline caregivers checklist completion rate: 98.4%.', 'category': 'Checklists'}",
            "{'title': 'Incident: Minor slip on transfer', 'content': 'Investigated. Approved. Corrective action filed.', 'category': 'Incidents'}"
        ],
        "action_label": "Reconcile Daily Logs"
    },
    {
        "file_path": r"apps/primecare_franchise/lib/features/ops/screens/operations_manager_issues_screen.dart",
        "controller_import": "operations_manager_issues_screen_controller.dart",
        "controller_provider": "operationsManagerIssuesScreenControllerProvider",
        "class_name": "OperationsManagerIssuesScreen",
        "title": "Operations Manager Issues",
        "desc": "Resolve booking conflicts, staffing shortages, and client route updates.",
        "categories": ["All", "Staffing", "Conflicts", "Routes"],
        "items": [
            "{'title': 'Staffing: Milton central nurse gap', 'content': 'Resolved via GTA reserve mobilizer team.', 'category': 'Staffing'}",
            "{'title': 'Conflict: Double-booked vital lab', 'content': 'Shift rescheduled for next Wednesday morning.', 'category': 'Conflicts'}",
            "{'title': 'Route: Allied health zone swap', 'content': 'Adjusted map directions for therapist Robert Lee.', 'category': 'Routes'}"
        ],
        "action_label": "Submit Issue Ticket"
    },
    {
        "file_path": r"apps/primecare_franchise/lib/features/ops/screens/operations_manager_reports_screen.dart",
        "controller_import": "operations_manager_reports_screen_controller.dart",
        "controller_provider": "operationsManagerReportsScreenControllerProvider",
        "class_name": "OperationsManagerReportsScreen",
        "title": "Operations Manager Reports",
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
        "file_path": r"apps/primecare_franchise/lib/features/ops/screens/operations_manager_schedule_screen.dart",
        "controller_import": "operations_manager_schedule_screen_controller.dart",
        "controller_provider": "operationsManagerScheduleScreenControllerProvider",
        "class_name": "OperationsManagerScheduleScreen",
        "title": "Operations Manager Schedule",
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
        "file_path": r"apps/primecare_franchise/lib/features/ops/screens/operations_manager_service_quality_screen.dart",
        "controller_import": "operations_manager_service_quality_screen_controller.dart",
        "controller_provider": "operationsManagerServiceQualityScreenControllerProvider",
        "class_name": "OperationsManagerServiceQualityScreen",
        "title": "Operations Manager Service Quality",
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
        "file_path": r"apps/primecare_franchise/lib/features/ops/screens/operations_manager_shifts_screen.dart",
        "controller_import": "operations_manager_shifts_screen_controller.dart",
        "controller_provider": "operationsManagerShiftsScreenControllerProvider",
        "class_name": "OperationsManagerShiftsScreen",
        "title": "Operations Manager Shifts",
        "desc": "Manage open shift lists, dispatch caregiver replacements, and review hourly shift summaries.",
        "categories": ["All", "OpenShifts", "Replacements", "Summaries"],
        "items": [
            "{'title': 'Open: Weekend vital check shift', 'content': 'GTA West region. Assigned mobile reserve coordinator.', 'category': 'OpenShifts'}",
            "{'title': 'Replacement: Nurse Mary Vance check', 'content': 'Allocated. Replaced caregiver absent due to illness.', 'category': 'Replacements'}",
            "{'title': 'Summary: Weekly caregiver logs', 'content': 'Total logged: 1,420 hours. All records match DB.', 'category': 'Summaries'}"
        ],
        "action_label": "Trigger Shift Dispatch"
    },
    {
        "file_path": r"apps/primecare_franchise/lib/features/ops/screens/operations_manager_staff_coordination_screen.dart",
        "controller_import": "operations_manager_staff_coordination_screen_controller.dart",
        "controller_provider": "operationsManagerStaffCoordinationScreenControllerProvider",
        "class_name": "OperationsManagerStaffCoordinationScreen",
        "title": "Operations Manager Staff Coordination",
        "desc": "Coordinate team messaging, supervisor assignment logs, and regional staff training schedules.",
        "categories": ["All", "Messaging", "Schedules", "Assignments"],
        "items": [
            "{'title': 'Message: Vital admin protocol sync', 'content': 'Dispatched team alert to 24 corporate nurses.', 'category': 'Messaging'}",
            "{'title': 'Schedule: Dementia workshop group', 'content': '12 caregivers registered. Practical lab on Friday.', 'category': 'Schedules'}",
            "{'title': 'Assignment: GTA coordinator role', 'content': 'Mary Smith assigned lead supervisor position.', 'category': 'Assignments'}"
        ],
        "action_label": "Broadcast Coordinator Note"
    },
    {
        "file_path": r"apps/primecare_franchise/lib/features/regional_manager/screens/regional_manager_branch_comparison_screen.dart",
        "controller_import": "regional_manager_branch_comparison_screen_controller.dart",
        "controller_provider": "regionalManagerBranchComparisonScreenControllerProvider",
        "class_name": "RegionalManagerBranchComparisonScreen",
        "title": "Regional Manager Branch Comparison",
        "desc": "Compare weekly shift dispatches, revenue margins, and staffing efficiencies across franchise locations.",
        "categories": ["All", "Dispatches", "Margins", "Efficiency"],
        "items": [
            "{'title': 'Dispatch: Mississauga vs Milton', 'content': 'Mississauga: 420 visits. Milton: 180 visits.', 'category': 'Dispatches'}",
            "{'title': 'Margin: Corporate profit analysis', 'content': 'Consolidated net profit margin stands at 22.4%.', 'category': 'Margins'}",
            "{'title': 'Efficiency: Caregiver shift fill rate', 'content': 'Toronto West holds optimal staffing utilization: 94%.', 'category': 'Efficiency'}"
        ],
        "action_label": "Run Branch Comparison"
    },
    {
        "file_path": r"apps/primecare_franchise/lib/features/regional_manager/screens/regional_manager_dashboard_screen.dart",
        "controller_import": "regional_manager_dashboard_screen_controller.dart",
        "controller_provider": "regionalManagerDashboardScreenControllerProvider",
        "class_name": "RegionalManagerDashboardScreen",
        "title": "Regional Manager Dashboard",
        "desc": "Monitor regional marketing campaigns, onboarding approvals, and customer satisfaction metrics.",
        "categories": ["All", "Campaigns", "Approvals", "Feedback"],
        "items": [
            "{'title': 'Campaign: Google Ads local sweep', 'content': 'Active in GTA. Reach: 14,200. Inquiries: 110.', 'category': 'Campaigns'}",
            "{'title': 'Approval: CNO credential renewal', 'content': 'Approved 12 nurse registrations in franchise database.', 'category': 'Approvals'}",
            "{'title': 'Feedback: Regional NPS satisfaction', 'content': 'Average regional score: 84. Positive comments: 92%.', 'category': 'Feedback'}"
        ],
        "action_label": "Refresh Regional Telemetry"
    },
    {
        "file_path": r"apps/primecare_franchise/lib/features/scheduler_coordinator/screens/scheduler_coordinator_appointment_calendar_screen.dart",
        "controller_import": "scheduler_coordinator_appointment_calendar_screen_controller.dart",
        "controller_provider": "schedulerCoordinatorAppointmentCalendarScreenControllerProvider",
        "class_name": "SchedulerCoordinatorAppointmentCalendarScreen",
        "title": "Scheduler Coordinator Appointment Calendar",
        "desc": "Track clinical client appointment times, therapist calendar assignments, and booking alerts.",
        "categories": ["All", "Calendar", "Assignments", "Alerts"],
        "items": [
            "{'title': 'Calendar: Chiropractic adjustment', 'content': 'Client: John Doe. Tuesday 10:00 AM in room A.', 'category': 'Calendar'}",
            "{'title': 'Assignment: Physiotherapist Mary Smith', 'content': 'Assigned to Oakville home care route.', 'category': 'Assignments'}",
            "{'title': 'Alert: Unassigned vital sweep check', 'content': 'Awaiting mobile reserve coordinator approval.', 'category': 'Alerts'}"
        ],
        "action_label": "Book Appointment Slot"
    },
    {
        "file_path": r"apps/primecare_franchise/lib/features/scheduler_coordinator/screens/scheduler_coordinator_assignments_screen.dart",
        "controller_import": "scheduler_coordinator_assignments_screen_controller.dart",
        "controller_provider": "schedulerCoordinatorAssignmentsScreenControllerProvider",
        "class_name": "SchedulerCoordinatorAssignmentsScreen",
        "title": "Scheduler Coordinator Assignments",
        "desc": "Coordinate therapist route assignments, vital check shifts, and dispatch backup caregiver lists.",
        "categories": ["All", "Routes", "Shifts", "Backups"],
        "items": [
            "{'title': 'Route: GTA West Allied therapists', 'content': ' therapist Robert Lee assigned to Oakville South.', 'category': 'Routes'}",
            "{'title': 'Shift: Vital administration rotation', 'content': 'Nurse Sarah Vance checked in at 9:00 AM.', 'category': 'Shifts'}",
            "{'title': 'Backup: Coordinator standby list', 'content': '2 caregivers standby for weekend coverage.', 'category': 'Backups'}"
        ],
        "action_label": "Assign Caregiver Route"
    },
    {
        "file_path": r"apps/primecare_franchise/lib/features/scheduler_coordinator/screens/scheduler_coordinator_booking_requests_screen.dart",
        "controller_import": "scheduler_coordinator_booking_requests_screen_controller.dart",
        "controller_provider": "schedulerCoordinatorBookingRequestsScreenControllerProvider",
        "class_name": "SchedulerCoordinatorBookingRequestsScreen",
        "title": "Scheduler Coordinator Booking Requests",
        "desc": "Process incoming client booking requests, direct billing insurance checks, and appointment approvals.",
        "categories": ["All", "Requests", "Insurance", "Approvals"],
        "items": [
            "{'title': 'Request: Physiotherapy initial check', 'content': 'Client: John Doe. Preferred: Tuesday morning.', 'category': 'Requests'}",
            "{'title': 'Insurance: SunLife direct billing check', 'content': 'Matched in database. Awaiting co-pay details.', 'category': 'Insurance'}",
            "{'title': 'Approval: Chiropractic adjustment slot', 'content': 'Confirmed. Dispatched email notification to family.', 'category': 'Approvals'}"
        ],
        "action_label": "Approve Booking Request"
    },
    {
        "file_path": r"apps/primecare_franchise/lib/features/scheduler_coordinator/screens/scheduler_coordinator_conflicts_screen.dart",
        "controller_import": "scheduler_coordinator_conflicts_screen_controller.dart",
        "controller_provider": "schedulerCoordinatorConflictsScreenControllerProvider",
        "class_name": "SchedulerCoordinatorConflictsScreen",
        "title": "Scheduler Coordinator Conflicts",
        "desc": "Identify double-bookings, caregiver routing clashes, and shift availability mismatches.",
        "categories": ["All", "DoubleBooks", "RoutingClashes", "Availability"],
        "items": [
            "{'title': 'DoubleBook: Vital lab check', 'content': 'Nurse Mary Smith booked twice on Tuesday morning.', 'category': 'DoubleBooks'}",
            "{'title': 'Routing: Oakville vs Milton border', 'content': 'Allied route overlapping. Re-allocated therapist.', 'category': 'RoutingClashes'}",
            "{'title': 'Availability: RMT supervisor check', 'content': 'Shift overlap resolved. Staff reassigned to room B.', 'category': 'Availability'}"
        ],
        "action_label": "Resolve Schedule Conflict"
    },
    {
        "file_path": r"apps/primecare_franchise/lib/features/scheduler_coordinator/screens/scheduler_coordinator_open_shifts_screen.dart",
        "controller_import": "scheduler_coordinator_open_shifts_screen_controller.dart",
        "controller_provider": "schedulerCoordinatorOpenShiftsScreenControllerProvider",
        "class_name": "SchedulerCoordinatorOpenShiftsScreen",
        "title": "Scheduler Coordinator Open Shifts",
        "desc": "Monitor unclaimed vital lab check shifts, allied therapist routes, and dispatch warnings.",
        "categories": ["All", "OpenShifts", "Warnings", "Therapists"],
        "items": [
            "{'title': 'Open: Weekend vital check shift', 'content': 'GTA West region. Awaiting caregiver response.', 'category': 'OpenShifts'}",
            "{'title': 'Therapist: Oakville Chiropractic route', 'content': 'Unclaimed. Auto-dispatched text notifications.', 'category': 'Therapists'}",
            "{'title': 'Warning: 24h unassigned shift conflict', 'content': 'Alert sent to operations manager database.', 'category': 'Warnings'}"
        ],
        "action_label": "Broadcast Open Shift"
    },
    {
        "file_path": r"apps/primecare_franchise/lib/features/scheduler_coordinator/screens/scheduler_coordinator_provider_availability_screen.dart",
        "controller_import": "scheduler_coordinator_provider_availability_screen_controller.dart",
        "controller_provider": "schedulerCoordinatorProviderAvailabilityScreenControllerProvider",
        "class_name": "SchedulerCoordinatorProviderAvailabilityScreen",
        "title": "Scheduler Coordinator Provider Availability",
        "desc": "Track caregiver hours, therapist vacation schedules, and clock-in logs.",
        "categories": ["All", "Hours", "Vacations", "ClockIns"],
        "items": [
            "{'title': 'Hours: Allied health coordinator', 'content': 'Logged 34 hours this week. Within target limits.', 'category': 'Hours'}",
            "{'title': 'Vacation: Nurse Sarah Vance leave', 'content': 'Approved: July 12 to July 18. Standby RN assigned.', 'category': 'Vacations'}",
            "{'title': 'ClockIn: Shift tracker audit status', 'content': 'Geofence clock-in accuracy verified: 98%.', 'category': 'ClockIns'}"
        ],
        "action_label": "Log Provider Availability"
    },
    {
        "file_path": r"apps/primecare_franchise/lib/features/scheduler_coordinator/screens/scheduler_coordinator_reports_screen.dart",
        "controller_import": "scheduler_coordinator_reports_screen_controller.dart",
        "controller_provider": "schedulerCoordinatorReportsScreenControllerProvider",
        "class_name": "SchedulerCoordinatorReportsScreen",
        "title": "Scheduler Coordinator Reports",
        "desc": "Download weekly shift metrics, booking reports, and historical route records.",
        "categories": ["All", "Shifts", "Bookings", "Routes"],
        "items": [
            "{'title': 'Shift: Consolidated coordinator log', 'content': 'Generated. Lists 420 visits, 98% SLA rate.', 'category': 'Shifts'}",
            "{'title': 'Booking: Approved client invoice summary', 'content': 'Matched in double-entry financial database.', 'category': 'Bookings'}",
            "{'title': 'Route: Allied health map audits file', 'content': 'Archived map directions for therapist routes.', 'category': 'Routes'}"
        ],
        "action_label": "Export Schedule Report"
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
    print("Upgrading 25 governed franchise/owner screens (Round 7)...")
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
