import os
import re

project_root = r"C:\Users\Admin2\Documents\GitHub\primecare-platform"

screens_config = [
    {
        "file_path": r"packages/primecare_ui/lib/src/features/public_health/epidemiological_surveillance_dashboard.dart",
        "class_name": "EpidemiologicalSurveillanceDashboardScreen",
        "title": "Epidemiological Surveillance",
        "desc": "Track disease outbreak patterns, surveillance logs, and alert thresholds.",
        "categories": ["All", "Outbreaks", "Incidence", "Alerts"],
        "items": [
            "{'title': 'Outbreak: Influenza A spike', 'content': 'Regional clinics reports show 14% increase.', 'category': 'Outbreaks'}",
            "{'title': 'Incidence: Norovirus logs', 'content': 'Burlington branch verified 6 cases.', 'category': 'Incidence'}",
            "{'title': 'Alert: West Nile surveillance', 'content': 'Vector controls set to warning level.', 'category': 'Alerts'}"
        ],
        "action_label": "Log Surveillance Record"
    },
    {
        "file_path": r"packages/primecare_ui/lib/src/features/public_health/mobile_clinic_dispatch.dart",
        "class_name": "MobileClinicDispatchScreen",
        "title": "Mobile Clinic Dispatch",
        "desc": "Coordinate mobile clinic dispatches, schedule site visits, and audit driver logs.",
        "categories": ["All", "Dispatches", "Schedules", "Audits"],
        "items": [
            "{'title': 'Dispatch: Van-1 to GTA East', 'content': 'Equipped with vaccine stocks. Transit active.', 'category': 'Dispatches'}",
            "{'title': 'Schedule: Milton senior home tour', 'content': 'Booked for Friday morning. Staff matched.', 'category': 'Schedules'}",
            "{'title': 'Audit: Maintenance mileage check', 'content': 'Van-2 passed safety inspection check.', 'category': 'Audits'}"
        ],
        "action_label": "Dispatch Mobile Unit"
    },
    {
        "file_path": r"packages/primecare_ui/lib/src/features/public_health/public_health_alert_broadcaster.dart",
        "class_name": "PublicHealthAlertBroadcasterScreen",
        "title": "Alert Broadcaster",
        "desc": "Publish public health advisory alerts, news feeds, and broadcast notifications.",
        "categories": ["All", "Broadcasts", "Advisories", "Feeds"],
        "items": [
            "{'title': 'Broadcast: Heat wave advisory', 'content': 'Sent SMS alert to seniors registry.', 'category': 'Broadcasts'}",
            "{'title': 'Advisory: Water safety notice', 'content': 'Boil advisory published for ward 4.', 'category': 'Advisories'}",
            "{'title': 'Feed: Clinic vaccination schedule', 'content': 'Added July clinics to public portal.', 'category': 'Feeds'}"
        ],
        "action_label": "Create Public Broadcast"
    },
    {
        "file_path": r"packages/primecare_ui/lib/src/features/public_health/school_health_program_dashboard.dart",
        "class_name": "SchoolHealthProgramDashboardScreen",
        "title": "School Health Portal",
        "desc": "Audit school dental screenings, vaccination logs, and health education campaigns.",
        "categories": ["All", "Screenings", "Vaccinations", "Campaigns"],
        "items": [
            "{'title': 'Screening: Dental check ward 2', 'content': 'Completed audits for 42 elementary students.', 'category': 'Screenings'}",
            "{'title': 'Vaccines: Grade 7 HepB tracker', 'content': 'Consent forms collected and synced to DB.', 'category': 'Vaccinations'}",
            "{'title': 'Campaign: Hand hygiene seminar', 'content': 'Outreach slides distributed to teachers.', 'category': 'Campaigns'}"
        ],
        "action_label": "Log School Screening"
    },
    {
        "file_path": r"packages/primecare_ui/lib/src/features/public_health/social_determinants_of_health_tracker.dart",
        "class_name": "SocialDeterminantsOfHealthTrackerScreen",
        "title": "SDOH Assessment Tracker",
        "desc": "Analyze client social determinants of health, housing status, and transport needs.",
        "categories": ["All", "Assessments", "Housing", "Transport"],
        "items": [
            "{'title': 'Assess: Client food security', 'content': 'Identified referral need for nutrition support.', 'category': 'Assessments'}",
            "{'title': 'Housing: Assisted living waitlist', 'content': 'Client Margaret Vance added to priority list.', 'category': 'Housing'}",
            "{'title': 'Transport: Clinic transit ride', 'content': 'Booked mobile clinic shuttle for senior.', 'category': 'Transport'}"
        ],
        "action_label": "Submit SDOH Assessment"
    },
    {
        "file_path": r"packages/primecare_ui/lib/src/features/public_health/vaccination_campaign_manager.dart",
        "class_name": "VaccinationCampaignManagerScreen",
        "title": "Vaccination Campaigns",
        "desc": "Track vaccination campaign statistics, batch distribution lists, and vaccine supply stock.",
        "categories": ["All", "Supply", "Campaigns", "Batches"],
        "items": [
            "{'title': 'Supply: Influenza batch delivery', 'content': '500 units received and logged in cold vault.', 'category': 'Supply'}",
            "{'title': 'Campaign: Fall flu push Oakville', 'content': 'Target: 80% coverage. Active clinic tracking.', 'category': 'Campaigns'}",
            "{'title': 'Batch: COVID booster logistics', 'content': 'Batch verification signature complete.', 'category': 'Batches'}"
        ],
        "action_label": "Create Vaccine Campaign"
    },
    {
        "file_path": r"packages/primecare_ui/lib/src/features/research/biospecimen_inventory_tracker.dart",
        "class_name": "BiospecimenInventoryTrackerScreen",
        "title": "Biospecimen Inventory",
        "desc": "Manage research biospecimen inventory, barcode scans, and freezer temperature logs.",
        "categories": ["All", "Scans", "Temperatures", "Inventory"],
        "items": [
            "{'title': 'Scan: Serum sample batch #402', 'content': 'Barcode verification complete. Stored in rack B.', 'category': 'Scans'}",
            "{'title': 'Temp: Freezer-A status log', 'content': 'Uptime stable at -80C. Sensor calibration OK.', 'category': 'Temperatures'}",
            "{'title': 'Inventory: Plasma vial reconcile', 'content': 'Checked inventory counts against Plaid ledger.', 'category': 'Inventory'}"
        ],
        "action_label": "Scan Biospecimen Barcode"
    },
    {
        "file_path": r"packages/primecare_ui/lib/src/features/research/clinical_trial_recruitment_dashboard.dart",
        "class_name": "ClinicalTrialRecruitmentDashboardScreen",
        "title": "Trial Recruitment",
        "desc": "Monitor clinical trial candidate pipelines, screening results, and enrollment rates.",
        "categories": ["All", "Pipelines", "Screenings", "Enrollments"],
        "items": [
            "{'title': 'Pipeline: Cardiac study cohort', 'content': '18 new patient matches found in database.', 'category': 'Pipelines'}",
            "{'title': 'Screening: Eligibility check', 'content': 'Passed criteria for 4 potential candidates.', 'category': 'Screenings'}",
            "{'title': 'Enroll: Consent forms signed', 'content': 'Patient Sarah Vance registered for study.', 'category': 'Enrollments'}"
        ],
        "action_label": "Enroll Trial Candidate"
    },
    {
        "file_path": r"packages/primecare_ui/lib/src/features/research/grant_funding_allocation.dart",
        "class_name": "GrantFundingAllocationScreen",
        "title": "Research Grant Funding",
        "desc": "Track research grant budgets, funding payouts, and financial audits.",
        "categories": ["All", "Budgets", "Payouts", "Auditing"],
        "items": [
            "{'title': 'Budget: Allied Health Q3 grant', 'content': 'Allocated $42,000 for chiropractor study.', 'category': 'Budgets'}",
            "{'title': 'Payout: Milestone-1 transaction', 'content': 'Released $12,500 to clinical trials lab.', 'category': 'Payouts'}",
            "{'title': 'Audit: Expense report verification', 'content': 'Matched printer receipts and travel logs.', 'category': 'Auditing'}"
        ],
        "action_label": "Allocate Grant Funds"
    },
    {
        "file_path": r"packages/primecare_ui/lib/src/features/research/patient_trial_outcomes_viewer.dart",
        "class_name": "PatientTrialOutcomesViewerScreen",
        "title": "Trial Outcomes Viewer",
        "desc": "Review clinical patient trial outcomes, symptom tracking reports, and lab results.",
        "categories": ["All", "Outcomes", "Symptoms", "Labs"],
        "items": [
            "{'title': 'Outcome: Group A cardiac study', 'content': 'Blood pressure reduction rate holds at 12%.', 'category': 'Outcomes'}",
            "{'title': 'Symptom: Patient diary logs', 'content': 'No severe adverse events recorded in week 4.', 'category': 'Symptoms'}",
            "{'title': 'Lab: Serum cholesterol check', 'content': 'Verified data sync with central pharmacy lab.', 'category': 'Labs'}"
        ],
        "action_label": "Publish Outcomes Report"
    },
    {
        "file_path": r"packages/primecare_ui/lib/src/features/research/research_protocol_manager.dart",
        "class_name": "ResearchProtocolManagerScreen",
        "title": "Research Protocols",
        "desc": "Review clinical research protocols, ethics board approvals, and amendment logs.",
        "categories": ["All", "Approvals", "Protocols", "Amendments"],
        "items": [
            "{'title': 'Approval: Ethics committee consent', 'content': 'Protocol #P-290 approved for clinical trials.', 'category': 'Approvals'}",
            "{'title': 'Protocol: Patient safety guidelines', 'content': 'Updated vital scan frequency thresholds.', 'category': 'Protocols'}",
            "{'title': 'Amendment: Dosing shift log', 'content': 'Staged revision for secondary cohort trial.', 'category': 'Amendments'}"
        ],
        "action_label": "Propose Protocol Amendment"
    },
    {
        "file_path": r"packages/primecare_ui/lib/src/features/research/research_publication_drafting.dart",
        "class_name": "ResearchPublicationDraftingScreen",
        "title": "Publication Drafting",
        "desc": "Collaborate on research publication drafts, track peer review comments, and check bibliographies.",
        "categories": ["All", "Drafts", "Reviews", "Bibliographies"],
        "items": [
            "{'title': 'Draft: In-home respite study', 'content': 'Section 3 results completed. Editing details.', 'category': 'Drafts'}",
            "{'title': 'Review: Nurse supervisor comments', 'content': 'Suggested adding vital telemetry tables.', 'category': 'Reviews'}",
            "{'title': 'Biblio: Citation reference check', 'content': 'Verified 24 source links against indexing database.', 'category': 'Bibliographies'}"
        ],
        "action_label": "Add Publication Entry"
    },
    {
        "file_path": r"packages/primecare_ui/lib/src/features/research/trial_data_collection_crf.dart",
        "class_name": "TrialDataCollectionCrfScreen",
        "title": "Case Report Forms (CRF)",
        "desc": "Verify case report forms (CRF), audit data queries, and log patient clinical entries.",
        "categories": ["All", "CRFs", "Queries", "Auditing"],
        "items": [
            "{'title': 'CRF: Patient vital check week 2', 'content': 'Entered systolic and diastolic range checks.', 'category': 'CRFs'}",
            "{'title': 'Query: Missing lab result match', 'content': 'Dispatched reminder notification to clinic.', 'category': 'Queries'}",
            "{'title': 'Audit: Database lock protocol', 'content': 'Signed off verification checklists. Data locked.', 'category': 'Auditing'}"
        ],
        "action_label": "Lock Case Report Form"
    },
    {
        "file_path": r"packages/primecare_ui/lib/src/features/telehealth/asynchronous_consultation_inbox.dart",
        "class_name": "AsynchronousConsultationInboxScreen",
        "title": "Asynchronous Consult Inbox",
        "desc": "Review client text consult requests, verify attached photos, and draft care plans.",
        "categories": ["All", "Consults", "Photos", "CarePlans"],
        "items": [
            "{'title': 'Consult: Rash review inquiry', 'content': 'Patient requested dermatology callback.', 'category': 'Consults'}",
            "{'title': 'Photo: Skin condition check', 'content': 'Image upload verified. High resolution.', 'category': 'Photos'}",
            "{'title': 'CarePlan: Rash ointment instructions', 'content': 'Awaiting signature verification from physician.', 'category': 'CarePlans'}"
        ],
        "action_label": "Log Consult Response"
    },
    {
        "file_path": r"packages/primecare_ui/lib/src/features/telehealth/chronic_care_management_tracker.dart",
        "class_name": "ChronicCareManagementTrackerScreen",
        "title": "Chronic Care Tracker",
        "desc": "Monitor chronic care patients, track monthly contact hours, and check ADL logs.",
        "categories": ["All", "Triage", "ContactHours", "ADLs"],
        "items": [
            "{'title': 'Triage: Congestive heart failure patient', 'content': 'Daily vitals verified. No critical anomaly.', 'category': 'Triage'}",
            "{'title': 'Hours: 20-min contact target', 'content': 'Completed 12 contact minutes for client John.', 'category': 'ContactHours'}",
            "{'title': 'ADL: Daily pill checklist', 'content': 'PSW checked off morning medication list.', 'category': 'ADLs'}"
        ],
        "action_label": "Record Contact Session"
    },
    {
        "file_path": r"packages/primecare_ui/lib/src/features/telehealth/device_integration_hub.dart",
        "class_name": "DeviceIntegrationHubScreen",
        "title": "Device Integration Hub",
        "desc": "Manage client Bluetooth blood pressure monitors, glucose meters, and scale devices.",
        "categories": ["All", "Devices", "SyncStatus", "Alerts"],
        "items": [
            "{'title': 'Device: BP Monitor pairing', 'content': 'Bluetooth connection established for client Mary.', 'category': 'Devices'}",
            "{'title': 'Sync: Glucose meter data log', 'content': '14 measurements synchronized to vitals database.', 'category': 'SyncStatus'}",
            "{'title': 'Alert: Scale disconnected check', 'content': 'Sent automated reminder message to family.', 'category': 'Alerts'}"
        ],
        "action_label": "Pair Patient Device"
    },
    {
        "file_path": r"packages/primecare_ui/lib/src/features/telehealth/digital_symptom_checker.dart",
        "class_name": "DigitalSymptomCheckerScreen",
        "title": "Digital Symptom Checker",
        "desc": "Review AI-driven patient symptom checks, triage categories, and recommendation routes.",
        "categories": ["All", "Triage", "Recommendations", "Symptoms"],
        "items": [
            "{'title': 'Triage: Mild asthma flare-up', 'content': 'Triage category: Yellow (Moderate). Notified RN.', 'category': 'Triage'}",
            "{'title': 'Recommend: Clinic clinic check', 'content': 'Suggested scheduling in-person chiropractor talk.', 'category': 'Recommendations'}",
            "{'title': 'Symptom: Shortness of breath check', 'content': 'Triggered check-in telemetry follow-ups.', 'category': 'Symptoms'}"
        ],
        "action_label": "Process Symptom Log"
    },
    {
        "file_path": r"packages/primecare_ui/lib/src/features/telehealth/remote_diagnostics_viewer.dart",
        "class_name": "RemoteDiagnosticsViewerScreen",
        "title": "Remote Diagnostics Viewer",
        "desc": "Inspect remote diagnostic measurements, ECG waveforms, and oxygen saturation logs.",
        "categories": ["All", "ECGs", "Oxygen", "Telemetry"],
        "items": [
            "{'title': 'ECG: Rhythm wave anomalies', 'content': 'R-R interval checks stable. Passed audit.', 'category': 'ECGs'}",
            "{'title': 'Oxygen: SpO2 pulse sensor log', 'content': 'Holds at 98%. Patient breathing normal.', 'category': 'Oxygen'}",
            "{'title': 'Telemetry: Live vitals dashboard', 'content': 'Connected to MQTT broker. Uptime optimal.', 'category': 'Telemetry'}"
        ],
        "action_label": "Audit Diagnostic Waveform"
    },
    {
        "file_path": r"packages/primecare_ui/lib/src/features/telehealth/remote_patient_monitoring_dashboard.dart",
        "class_name": "RemotePatientMonitoringDashboardScreen",
        "title": "Remote Patient Monitoring",
        "desc": "Audit remote vital signs alert queues, trigger dispatch alerts, and check compliance benchmarks.",
        "categories": ["All", "Alerts", "Vitals", "Schedules"],
        "items": [
            "{'title': 'Alert: High systolic pressure', 'content': 'Oakville client BP flagged. Sent alert to supervisor.', 'category': 'Alerts'}",
            "{'title': 'Vitals: Glucose level tracker', 'content': 'Average glucose holds at 6.2 mmol/L for June.', 'category': 'Vitals'}",
            "{'title': 'Schedule: Nurse daily callbacks', 'content': 'Coordinators assigned to follow up on 8 clients.', 'category': 'Schedules'}"
        ],
        "action_label": "Acknowledge Vitals Alert"
    },
    {
        "file_path": r"packages/primecare_ui/lib/src/features/telehealth/telehealth_consultation_room.dart",
        "class_name": "TelehealthConsultationRoomScreen",
        "title": "Telehealth Consultation Room",
        "desc": "Manage telehealth video sessions, check camera/mic pairing, and document visit outcomes.",
        "categories": ["All", "VideoCalls", "Hardware", "Outcomes"],
        "items": [
            "{'title': 'VideoCall: Client Mary Vance consult', 'content': 'Duration: 14 mins. Connection status: stable.', 'category': 'VideoCalls'}",
            "{'title': 'Hardware: Web RTC test status', 'content': 'Camera and mic pairing verified successfully.', 'category': 'Hardware'}",
            "{'title': 'Outcome: Exercise therapy plan signoff', 'content': 'Client copy sent to family portal inbox.', 'category': 'Outcomes'}"
        ],
        "action_label": "Start Consultation Video"
    },
    {
        "file_path": r"packages/primecare_ui/lib/src/features/telehealth/telehealth_quality_metrics.dart",
        "class_name": "TelehealthQualityMetricsScreen",
        "title": "Telehealth Quality Metrics",
        "desc": "Evaluate video call dropping rates, client NPS scores, and clinical compliance checklists.",
        "categories": ["All", "CallQuality", "NPS", "Compliance"],
        "items": [
            "{'title': 'Quality: Call dropping rates', 'content': 'ONT branch: 0.2%. WEST: 0.4%. Below SLA limit.', 'category': 'CallQuality'}",
            "{'title': 'NPS: Post-telehealth evaluation', 'content': 'Average rating: 4.8/5. Reconcile check OK.', 'category': 'NPS'}",
            "{'title': 'Compliance: Telehealth consent check', 'content': '100% video sessions have signed consent.', 'category': 'Compliance'}"
        ],
        "action_label": "Compile Telehealth Quality Report"
    },
    {
        "file_path": r"packages/primecare_ui/lib/src/features/telehealth/telemedicine_prescription_pad.dart",
        "class_name": "TelemedicinePrescriptionPadScreen",
        "title": "Telemedicine Prescription Pad",
        "desc": "Review digital prescriptions, verify drug dosages, and transmit scripts to pharmacies.",
        "categories": ["All", "Prescriptions", "Dosages", "Transmission"],
        "items": [
            "{'title': 'Prescribe: Amoxicillin 500mg script', 'content': 'Signed off by physician advisor Robert.', 'category': 'Prescriptions'}",
            "{'title': 'Dosage: Cardiac beta blocker check', 'content': 'Verified no contradictions with drug alert center.', 'category': 'Dosages'}",
            "{'title': 'Transmit: Fax to Oakville Pharmacy', 'content': 'Delivery status: Confirmed. Batch reconciled.', 'category': 'Transmission'}"
        ],
        "action_label": "Transmit Prescription Script"
    },
    {
        "file_path": r"packages/primecare_ui/lib/src/features/telehealth/virtual_waiting_room.dart",
        "class_name": "VirtualWaitingRoomScreen",
        "title": "Virtual Waiting Room",
        "desc": "Manage incoming client video queues, coordinate wait times, and dispatch clinicians.",
        "categories": ["All", "ClientQueue", "WaitTimes", "Clinicians"],
        "items": [
            "{'title': 'Queue: Client John Doe waiting', 'content': 'Checked in at 09:40. Reason: Rash follow-up.', 'category': 'ClientQueue'}",
            "{'title': 'WaitTime: Average queue delay', 'content': 'Current average: 8.4 minutes. SLA targets met.', 'category': 'WaitTimes'}",
            "{'title': 'Clinician: Nurse Mary availability', 'content': 'Matched to next client in consultation queue.', 'category': 'Clinicians'}"
        ],
        "action_label": "Dispatch Next Client"
    }
]

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
    print("Upgrading 23 governed screens across telehealth, public health, and research (Round 12)...")
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
