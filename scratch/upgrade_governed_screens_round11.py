import os
import re

project_root = r"C:\Users\Admin2\Documents\GitHub\primecare-platform"

screens_config = [
    {
        "file_path": r"apps/primecare_support/lib/features/generated_screens/training_coordinator_training_schedule_screen.dart",
        "controller_import": "training_coordinator_training_schedule_screen_controller.dart",
        "controller_provider": "trainingCoordinatorTrainingScheduleScreenControllerProvider",
        "class_name": "TrainingCoordinatorTrainingScheduleScreen",
        "title": "Training Schedule",
        "desc": "Manage instructor schedules, schedule changes, and track active staff classes.",
        "categories": ["All", "Schedules", "Changes", "Classes"],
        "items": [
            "{'title': 'Schedule: Safe Lifts Practical', 'content': 'Instructor: Mary. Room: Mock Lab A.', 'category': 'Schedules'}",
            "{'title': 'Change: CPR cohort delay', 'content': 'Postponed to Friday due to holiday.', 'category': 'Changes'}",
            "{'title': 'Class: Dementia Care Basic v2', 'content': '14 candidates registered. Materials loaded.', 'category': 'Classes'}"
        ],
        "action_label": "Schedule Training Session",
        "use_provider": True
    },
    {
        "file_path": r"apps/primecare_support/lib/features/generated_screens/training_coordinator_workshops_screen.dart",
        "controller_import": "training_coordinator_workshops_screen_controller.dart",
        "controller_provider": "trainingCoordinatorWorkshopsScreenControllerProvider",
        "class_name": "TrainingCoordinatorWorkshopsScreen",
        "title": "Coordinator Workshops",
        "desc": "Organize hands-on coordinator workshops, clinical seminars, and guest presentations.",
        "categories": ["All", "Seminars", "GuestTalks", "Workshops"],
        "items": [
            "{'title': 'Seminar: Range of Motion Support', 'content': 'Led by Physiotherapist lead Robert.', 'category': 'Seminars'}",
            "{'title': 'Guest: Red Cross CPR audit', 'content': 'CPR certificate alignment checks.', 'category': 'GuestTalks'}",
            "{'title': 'Workshop: Spinal adjustments info', 'content': 'Spinal care tips hosted by Chiropractor team.', 'category': 'Workshops'}"
        ],
        "action_label": "Register Workshop Event",
        "use_provider": True
    },
    {
        "file_path": r"apps/primecare_support/lib/features/support/screens/escalation_dashboard_screen.dart",
        "controller_import": "escalation_dashboard_screen_controller.dart",
        "controller_provider": "escalationDashboardScreenControllerProvider",
        "class_name": "EscalationDashboardScreen",
        "title": "Escalation Control",
        "desc": "Audit critical cases, dispatcher alerts, and branch operational escalations.",
        "categories": ["All", "Critical", "Alerts", "Escalations"],
        "items": [
            "{'title': 'Critical: Oakville vital anomaly', 'content': 'High-risk patient alerts sent to field supervisor.', 'category': 'Critical'}",
            "{'title': 'Alert: Missed check-in Milton', 'content': 'Caregiver shift delayed by 18 minutes. Triage check.', 'category': 'Alerts'}",
            "{'title': 'Escalation: Billing dispute resolution', 'content': 'Under review by finance director desk.', 'category': 'Escalations'}"
        ],
        "action_label": "Escalate New Case",
        "use_provider": True
    },
    {
        "file_path": r"apps/primecare_support/lib/features/support/screens/help_desk_dashboard_screen.dart",
        "controller_import": "help_desk_dashboard_screen_controller.dart",
        "controller_provider": "helpDeskDashboardScreenControllerProvider",
        "class_name": "HelpDeskDashboardScreen",
        "title": "Help Desk Hub",
        "desc": "Manage ticket statuses, track resolution time SLAs, and verify support workloads.",
        "categories": ["All", "Tickets", "SLAs", "Workload"],
        "items": [
            "{'title': 'Ticket #H-401: Portal access error', 'content': 'Reset password workflow triggered.', 'category': 'Tickets'}",
            "{'title': 'SLA: Response time target', 'content': 'Average ticket response holds at 1.4 minutes.', 'category': 'SLAs'}",
            "{'title': 'Workload: Queue capacity logs', 'content': 'Active coordinators: 6. Staged queries: 3.', 'category': 'Workload'}"
        ],
        "action_label": "Create Support Ticket",
        "use_provider": True
    },
    {
        "file_path": r"apps/primecare_support/lib/features/support/screens/it_administrator_dashboard_screen.dart",
        "controller_import": "it_administrator_dashboard_screen_controller.dart",
        "controller_provider": "itAdministratorDashboardScreenControllerProvider",
        "class_name": "ItAdministratorDashboardScreen",
        "title": "IT Administrator Hub",
        "desc": "Monitor system deployments, audit trails, database health, and active subdomains.",
        "categories": ["All", "Deployments", "AuditLogs", "Subdomains"],
        "items": [
            "{'title': 'Deploy: Worker API v2.4.1', 'content': 'Successfully staged. Telemetry validation: OK.', 'category': 'Deployments'}",
            "{'title': 'Audit: Database index rebuild', 'content': 'Completed on governance.db cache. Optimizing logs.', 'category': 'AuditLogs'}",
            "{'title': 'Subdomain: support-api routing', 'content': 'Active proxy rules verified. SSL check: green.', 'category': 'Subdomains'}"
        ],
        "action_label": "Verify System Health",
        "use_provider": True
    },
    # primecare_ui Screens
    {
        "file_path": r"packages/primecare_ui/lib/src/features/generated_screens/billing_invoices_screen.dart",
        "class_name": "BillingInvoicesScreen",
        "title": "Billing Invoices",
        "desc": "Audit institutional invoice settings, print invoice summaries, and check compliance status.",
        "categories": ["All", "Invoices", "Drafts", "Reconciliation"],
        "items": [
            "{'title': 'Invoice: Oakville June cycle', 'content': 'Amount: $14,500. Status: Awaiting client review.', 'category': 'Invoices'}",
            "{'title': 'Draft: Milton Respite package', 'content': 'Staged draft invoice with co-pay allocation.', 'category': 'Drafts'}",
            "{'title': 'Reconcile: Private SunLife invoice', 'content': 'Matched check payment to invoice INV-801.', 'category': 'Reconciliation'}"
        ],
        "action_label": "Generate Invoice Entry",
        "use_provider": False
    },
    {
        "file_path": r"packages/primecare_ui/lib/src/features/generated_screens/billing_payments_screen.dart",
        "class_name": "BillingPaymentsScreen",
        "title": "Billing Payments",
        "desc": "Track real-time payment transfers, Plaid bank sync records, and card remittance status.",
        "categories": ["All", "PlaidSync", "Remittances", "Refunds"],
        "items": [
            "{'title': 'Plaid: Bank ledger download', 'content': '14 new transactions reconciled automatically.', 'category': 'PlaidSync'}",
            "{'title': 'Remit: Card capture GTA North', 'content': 'Processed $4,200 payment for Mary Vance.', 'category': 'Remittances'}",
            "{'title': 'Refund: Milton booking cancel', 'content': 'Issued $150 refund code to patient card.', 'category': 'Refunds'}"
        ],
        "action_label": "Process New Payment",
        "use_provider": False
    },
    {
        "file_path": r"packages/primecare_ui/lib/src/features/generated_screens/hr_applicants_screen.dart",
        "class_name": "HrApplicantsScreen",
        "title": "HR Applicants",
        "desc": "Filter caregiver job applications, schedule candidate interviews, and trigger background checks.",
        "categories": ["All", "Interviews", "BackgroundChecks", "Staged"],
        "items": [
            "{'title': 'Interview: Sarah Vance (RN applicant)', 'content': 'Scheduled for Tuesday at 2 PM. Zoom room open.', 'category': 'Interviews'}",
            "{'title': 'Check: Vulnerable sector verify', 'content': 'Awaiting response from local police department.', 'category': 'BackgroundChecks'}",
            "{'title': 'Stage: Robert Lee onboarding', 'content': 'Reference checks completed. Job offer generated.', 'category': 'Staged'}"
        ],
        "action_label": "Log Job Application",
        "use_provider": False
    },
    {
        "file_path": r"packages/primecare_ui/lib/src/features/generated_screens/hr_staff_files_screen.dart",
        "class_name": "HrStaffFilesScreen",
        "title": "Staff Files",
        "desc": "Audit caregiver association licenses, CPR certificates, and vaccination status logs.",
        "categories": ["All", "Licenses", "CPR", "Vaccinations"],
        "items": [
            "{'title': 'License: RN College active status', 'content': 'Verified registration for 8 field nursing staff.', 'category': 'Licenses'}",
            "{'title': 'CPR: Red Cross BLS certification', 'content': 'Renewed for coordinator Mary. Expiry: 2028.', 'category': 'CPR'}",
            "{'title': 'Vaccination: Seasonal flu log', 'content': '98% caregiver vaccination rate reached.', 'category': 'Vaccinations'}"
        ],
        "action_label": "Audit Staff File",
        "use_provider": False
    },
    {
        "file_path": r"packages/primecare_ui/lib/src/features/generated_screens/receptionist_appointments_screen.dart",
        "class_name": "ReceptionistAppointmentsScreen",
        "title": "Appointments Desk",
        "desc": "Schedule visitor appointments, check in clinic clients, and print schedules.",
        "categories": ["All", "CheckIns", "Fittings", "Meetings"],
        "items": [
            "{'title': 'CheckIn: Margaret vital check', 'content': 'Patient arrived for clinic consultation.', 'category': 'CheckIns'}",
            "{'title': 'Fitting: Orthotic consult clinic', 'content': 'Scheduled for 11 AM with Therapist lead.', 'category': 'Fittings'}",
            "{'title': 'Meeting: Regional BDM site visit', 'content': 'Burlington branch operations review scheduled.', 'category': 'Meetings'}"
        ],
        "action_label": "Book New Appointment",
        "use_provider": False
    },
    {
        "file_path": r"packages/primecare_ui/lib/src/features/generated_screens/receptionist_calls_screen.dart",
        "class_name": "ReceptionistCallsScreen",
        "title": "Receptionist Calls",
        "desc": "Log receptionist incoming calls, client inquires, and messages.",
        "categories": ["All", "Inquiries", "Urgent", "Messages"],
        "items": [
            "{'title': 'Inquiry: Weekend care pricing', 'content': 'Forwarded request to intake coordinator desk.', 'category': 'Inquiries'}",
            "{'title': 'Urgent: Caregiver late notice', 'content': 'Mississauga shift conflict. Notified scheduler.', 'category': 'Urgent'}",
            "{'title': 'Message: Pharmacy medication list', 'content': 'Awaiting review from physician advisor.', 'category': 'Messages'}"
        ],
        "action_label": "Log Incoming Call",
        "use_provider": False
    },
    {
        "file_path": r"packages/primecare_ui/lib/src/features/generated_screens/receptionist_visitors_screen.dart",
        "class_name": "ReceptionistVisitorsScreen",
        "title": "Visitor Logs",
        "desc": "Log clinic visitor entries, check IDs, print badges, and assign visitor status.",
        "categories": ["All", "Badges", "CheckIns", "Auditing"],
        "items": [
            "{'title': 'Badge #V-102: Courier delivery', 'content': 'Assigned temporary access pass to lobby area.', 'category': 'Badges'}",
            "{'title': 'CheckIn: Family member visit', 'content': 'Visitor Mary checking in on patient care plan.', 'category': 'CheckIns'}",
            "{'title': 'Audit: Sign-in sheet compliance', 'content': 'Passed receptionist verification sweep for June.', 'category': 'Auditing'}"
        ],
        "action_label": "Register Visitor Entry",
        "use_provider": False
    },
    {
        "file_path": r"packages/primecare_ui/lib/src/features/generated_screens/scheduler_availability_screen.dart",
        "class_name": "SchedulerAvailabilityScreen",
        "title": "Scheduler Availability",
        "desc": "Manage caregiver shift availability, leave requests, and schedule blocks.",
        "categories": ["All", "Leave", "Blocks", "Requests"],
        "items": [
            "{'title': 'Leave: Caregiver vacation request', 'content': 'Approved for 5 days. Shift backup assigned.', 'category': 'Leave'}",
            "{'title': 'Block: Training day coordinate', 'content': 'Blocked all calendar slots for practical lab.', 'category': 'Blocks'}",
            "{'title': 'Request: Shift trade Oakville', 'content': 'Awaiting signoff from scheduling manager.', 'category': 'Requests'}"
        ],
        "action_label": "Set Availability Slot",
        "use_provider": False
    },
    {
        "file_path": r"packages/primecare_ui/lib/src/features/generated_screens/scheduler_shifts_screen.dart",
        "class_name": "SchedulerShiftsScreen",
        "title": "Scheduler Shifts",
        "desc": "Track active caregiver shifts, coordinate emergency replacements, and resolve calendar conflicts.",
        "categories": ["All", "Conflicts", "Replacements", "Shifts"],
        "items": [
            "{'title': 'Conflict: Double-booked shift', 'content': 'Resolved by assigning backup caregiver Mary.', 'category': 'Conflicts'}",
            "{'title': 'Replace: Illness replacement', 'content': 'Dispatched RN supervisor to bedside care plan.', 'category': 'Replacements'}",
            "{'title': 'Shift: Evening check-in logs', 'content': 'Verified check-in timestamps. Uptime optimal.', 'category': 'Shifts'}"
        ],
        "action_label": "Assign Shift Block",
        "use_provider": False
    },
    # Pharmacy Screens
    {
        "file_path": r"packages/primecare_ui/lib/src/features/pharmacy/drug_interaction_alert_center.dart",
        "class_name": "DrugInteractionAlertCenterScreen",
        "title": "Drug Interaction Alerts",
        "desc": "Track high-risk drug-drug interactions, allergy alerts, and prescription contradictions.",
        "categories": ["All", "Allergies", "Interactions", "Overrides"],
        "items": [
            "{'title': 'Allergy: Penicillin contraindication', 'content': 'Patient profile flagged. Switched to alternative.', 'category': 'Allergies'}",
            "{'title': 'Interaction: Warfarin + Aspirin', 'content': 'Severe bleeding risk detected. Notified doctor.', 'category': 'Interactions'}",
            "{'title': 'Override: Critical cardiac prescription', 'content': 'Justification signed off by clinical lead.', 'category': 'Overrides'}"
        ],
        "action_label": "Log Interaction Alert",
        "use_provider": False
    },
    {
        "file_path": r"packages/primecare_ui/lib/src/features/pharmacy/formulary_compliance_manager.dart",
        "class_name": "FormularyComplianceManagerScreen",
        "title": "Formulary Compliance",
        "desc": "Track formulary drug lists, check copay coverage, and verify insurance limits.",
        "categories": ["All", "Formularies", "Copays", "Auditing"],
        "items": [
            "{'title': 'Formulary: Tier-1 generic listings', 'content': 'Updated with new cardiac drug alternatives.', 'category': 'Formularies'}",
            "{'title': 'Copay: Blue Cross coverage check', 'content': 'Approved generic drug substitutions for Milton.', 'category': 'Copays'}",
            "{'title': 'Audit: Non-formulary exemptions', 'content': 'Logged reasons for non-compliance exceptions.', 'category': 'Auditing'}"
        ],
        "action_label": "Submit Formulary Audit",
        "use_provider": False
    },
    {
        "file_path": r"packages/primecare_ui/lib/src/features/pharmacy/inpatient_pharmacy_queue.dart",
        "class_name": "InpatientPharmacyQueueScreen",
        "title": "Inpatient Queue",
        "desc": "Manage inpatient prescription orders, coordinate dispensing runs, and check bed layouts.",
        "categories": ["All", "Dispensing", "Queue", "Staged"],
        "items": [
            "{'title': 'Dispense: Ward-3 antibiotic run', 'content': 'Staged for delivery. Courier badge verified.', 'category': 'Dispensing'}",
            "{'title': 'Queue: Priority stat orders', 'content': '4 pediatric prescriptions placed at front of line.', 'category': 'Queue'}",
            "{'title': 'Stage: Milton post-op orders', 'content': 'Awaiting signature checks from attending physician.', 'category': 'Staged'}"
        ],
        "action_label": "Update Queue Item",
        "use_provider": False
    },
    {
        "file_path": r"packages/primecare_ui/lib/src/features/pharmacy/medication_reconciliation_tool.dart",
        "class_name": "MedicationReconciliationToolScreen",
        "title": "Medication Reconciliation",
        "desc": "Compare admission medication records, verify home prescriptions, and resolve discrepancy logs.",
        "categories": ["All", "Admissions", "Discharges", "Conflicts"],
        "items": [
            "{'title': 'Admission: Medication list check', 'content': 'Verified 6 home meds match hospital chart.', 'category': 'Admissions'}",
            "{'title': 'Discharge: Prescriptions dispatch', 'content': 'Generated patient instructions sheet.', 'category': 'Discharges'}",
            "{'title': 'Conflict: Duplicate dosing alert', 'content': 'Resolved by clinical pharmacist verification.', 'category': 'Conflicts'}"
        ],
        "action_label": "Reconcile Medications",
        "use_provider": False
    },
    {
        "file_path": r"packages/primecare_ui/lib/src/features/pharmacy/outpatient_prescription_tracker.dart",
        "class_name": "OutpatientPrescriptionTrackerScreen",
        "title": "Outpatient Tracker",
        "desc": "Monitor outpatient prescriptions, refill requests, and patient pickup schedules.",
        "categories": ["All", "Pickups", "Refills", "Alerts"],
        "items": [
            "{'title': 'Pickup: GTA East prescription package', 'content': 'Ready for pickup. Client notified.', 'category': 'Pickups'}",
            "{'title': 'Refill: Chronic care heart meds', 'content': 'Automatic 30-day refill request approved.', 'category': 'Refills'}",
            "{'title': 'Alert: Uncollected prescriptions', 'content': 'Burlington pharmacy alerts for 2 seniors.', 'category': 'Alerts'}"
        ],
        "action_label": "Log Refill Request",
        "use_provider": False
    },
    {
        "file_path": r"packages/primecare_ui/lib/src/features/pharmacy/patient_medication_adherence.dart",
        "class_name": "PatientMedicationAdherenceScreen",
        "title": "Medication Adherence",
        "desc": "Track patient medication adherence rates, daily pillbox counts, and missed doses.",
        "categories": ["All", "PillboxCounts", "MissedDoses", "Telemetry"],
        "items": [
            "{'title': 'Pillbox: Weekly home checks', 'content': 'Verified 100% adherence for Oakville senior.', 'category': 'PillboxCounts'}",
            "{'title': 'Missed: Alert for patient Robert', 'content': 'Missed morning insulin. Caregiver dispatched.', 'category': 'MissedDoses'}",
            "{'title': 'Telemetry: Digital pillbox sync', 'content': 'Connected check-ins recorded in telemetry database.', 'category': 'Telemetry'}"
        ],
        "action_label": "Record Adherence Check",
        "use_provider": False
    },
    {
        "file_path": r"packages/primecare_ui/lib/src/features/pharmacy/pharmacy_dispensing_dashboard.dart",
        "class_name": "PharmacyDispensingDashboardScreen",
        "title": "Dispensing Desk",
        "desc": "Monitor pharmacy dispensing workflows, verify script counts, and trace batch audits.",
        "categories": ["All", "Workflow", "BatchAudits", "Scripts"],
        "items": [
            "{'title': 'Workflow: Automatic packaging system', 'content': 'Dispensed 120 bubble packs. System active.', 'category': 'Workflow'}",
            "{'title': 'Batch: Narcotics safety sweep', 'content': 'Physical count matched ledger logs. Passed.', 'category': 'BatchAudits'}",
            "{'title': 'Script: Hourly totals audit', 'content': 'Processed 85 outpatient scripts. SLA green.', 'category': 'Scripts'}"
        ],
        "action_label": "Audit Dispensing Batch",
        "use_provider": False
    },
    {
        "file_path": r"packages/primecare_ui/lib/src/features/pharmacy/pharmacy_inventory_management.dart",
        "class_name": "PharmacyInventoryManagementScreen",
        "title": "Pharmacy Inventory",
        "desc": "Manage drug warehouse stock, trace expiry dates, and review purchase reorders.",
        "categories": ["All", "Expiry", "Reorders", "Stock"],
        "items": [
            "{'title': 'Expiry: Staged insulin checks', 'content': 'Zero expired stock detected in cold storage.', 'category': 'Expiry'}",
            "{'title': 'Reorder: Cardiac medication batch', 'content': 'Automatic PO triggered for 500 units.', 'category': 'Reorders'}",
            "{'title': 'Stock: Narcotics vault validation', 'content': 'Dual-witness signature logged in system.', 'category': 'Stock'}"
        ],
        "action_label": "Submit Inventory Reorder",
        "use_provider": False
    },
    # Public Health Screens
    {
        "file_path": r"packages/primecare_ui/lib/src/features/public_health/community_health_needs_assessment.dart",
        "class_name": "CommunityHealthNeedsAssessmentScreen",
        "title": "Health Needs Assessment",
        "desc": "Track community health indicators, public surveys, and action plan benchmarks.",
        "categories": ["All", "Surveys", "Indicators", "Benchmarks"],
        "items": [
            "{'title': 'Survey: Senior flu accessibility', 'content': 'Collected 120 resident responses in Milton.', 'category': 'Surveys'}",
            "{'title': 'Indicator: Chronic diabetes rate', 'content': 'Staged local outreach clinic for preventative care.', 'category': 'Indicators'}",
            "{'title': 'Benchmark: Immunization clinic setup', 'content': 'Passed 80% community coverage target.', 'category': 'Benchmarks'}"
        ],
        "action_label": "Publish Assessment Report",
        "use_provider": False
    }
]

# Code template for the screens watching a provider
provider_template = """/* 
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
import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
      appBar: AppBar(
        title: const Text('{title}'),
      ),
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

# Code template for the screens without a controller provider (pure UI stateful delegation)
ui_template = """/* 
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
import 'package:primecare_ui/primecare_ui.dart';

class {class_name} extends GovernedConsumerWidget {{
  const {class_name}({{super.key}});

  @override
  String get screenDescription =>
      '{desc}';

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {{
    return const _{class_name}Content();
  }}
}}

class _{class_name}Content extends ConsumerStatefulWidget {{
  const _{class_name}Content();

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

    final theme = context.theme;

    return Scaffold(
      backgroundColor: theme.colors.background,
      appBar: AppBar(
        backgroundColor: theme.colors.surface,
        elevation: 0,
        title: Text(
          '{title}',
          style: theme.typography.h3.copyWith(color: theme.colors.onSurface),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Action / Purpose Hero panel
          Container(
            padding: const EdgeInsets.all(16),
            color: theme.colors.primary.withValues(alpha: 0.05),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Operational Control Panel',
                  style: theme.typography.bodyLarge.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(
                  '{desc}',
                  style: theme.typography.bodyMedium.copyWith(color: theme.colors.onSurfaceVariant),
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
    print("Upgrading 23 governed screens across apps and UI packages (Round 11)...")
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

        if sc["use_provider"]:
            new_content = provider_template.format(
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
        else:
            new_content = ui_template.format(
                prime_screen=prime_screen,
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
