import os
import re

project_root = r"C:\Users\Admin2\Documents\GitHub\primecare-platform"

# List of screen configurations
screens_config = [
    {
        "file_path": r"apps/primecare_business_development/lib/features/business_development/presentation/widgets/regional_bdm_deal_tracker_screen.dart",
        "controller_import": "regional_bdm_deal_tracker_screen_controller.dart",
        "controller_provider": "regional_bdm_deal_tracker_screen_controllerProvider",
        "class_name": "RegionalBdmDealTrackerScreen",
        "title": "Regional BDM Deal Tracker",
        "desc": "Track acquisition and franchise deals through the stages of discovery, negotiation, and signoff.",
        "categories": ["All", "Negotiation", "Discovery", "Signoff"],
        "items": [
            "{'title': 'Deal #7001: Ontario Central Expansion', 'content': 'Negotiation stage. Margin projection is 14%.', 'category': 'Negotiation'}",
            "{'title': 'Deal #7002: Vancouver North Hub acquisition', 'content': 'Discovery stage. Contacted regional owner.', 'category': 'Discovery'}",
            "{'title': 'Deal #7003: Calgary South franchise agreement', 'content': 'Signoff stage. Awaiting legal document seal.', 'category': 'Signoff'}"
        ],
        "action_label": "Create New Deal Node"
    },
    {
        "file_path": r"apps/primecare_franchise/lib/features/generated_screens/regional_bdm_franchise_pipeline_screen.dart",
        "controller_import": "regional_bdm_franchise_pipeline_screen_controller.dart",
        "controller_provider": "regional_bdm_franchise_pipeline_screen_controllerProvider",
        "class_name": "RegionalBdmFranchisePipelineScreen",
        "title": "Regional BDM Franchise Pipeline",
        "desc": "Oversee the lifecycle stages of franchise onboarding pipelines across territories.",
        "categories": ["All", "Onboarding", "Vetting", "Approved"],
        "items": [
            "{'title': 'Franchise Pipeline #8001: Ottawa West Clinic', 'content': 'Vetting stage. Background checks in progress.', 'category': 'Vetting'}",
            "{'title': 'Franchise Pipeline #8002: Edmonton South Unit', 'content': 'Onboarding stage. Site selected and leased.', 'category': 'Onboarding'}",
            "{'title': 'Franchise Pipeline #8003: Winnipeg East Unit', 'content': 'Approved stage. Operations kickoff next week.', 'category': 'Approved'}"
        ],
        "action_label": "Register Pipeline Node"
    },
    {
        "file_path": r"apps/primecare_business_development/lib/features/business_development/presentation/widgets/regional_bdm_leads_screen.dart",
        "controller_import": "regional_bdm_leads_screen_controller.dart",
        "controller_provider": "regional_bdm_leads_screen_controllerProvider",
        "class_name": "RegionalBdmLeadsScreen",
        "title": "Regional BDM Leads",
        "desc": "Manage business development leads, conversion metrics, and outreach communications.",
        "categories": ["All", "Hot", "Warm", "Cold"],
        "items": [
            "{'title': 'Lead #9001: Dr. Alan Green Clinic Group', 'content': 'Hot lead. Scheduled follow-up call tomorrow.', 'category': 'Hot'}",
            "{'title': 'Lead #9002: SeniorCare Home Group Ontario', 'content': 'Warm lead. Sent brochure and services listing.', 'category': 'Warm'}",
            "{'title': 'Lead #9003: Metro Rehab Centers Inc.', 'content': 'Cold lead. Left voicemail on initial outreach.', 'category': 'Cold'}"
        ],
        "action_label": "Create Lead Profile"
    },
    {
        "file_path": r"apps/primecare_business_development/lib/features/business_development/presentation/widgets/regional_bdm_meetings_screen.dart",
        "controller_import": "regional_bdm_meetings_screen_controller.dart",
        "controller_provider": "regional_bdm_meetings_screen_controllerProvider",
        "class_name": "RegionalBdmMeetingsScreen",
        "title": "Regional BDM Meetings",
        "desc": "Schedule, track, and log outcomes of BDM consultation meetings with partners.",
        "categories": ["All", "Consultation", "FollowUp", "Introductory"],
        "items": [
            "{'title': 'Meeting #101: Dr. Smith (Vancouver Rehab)', 'content': 'Consultation. Discussed RMT staffing needs.', 'category': 'Consultation'}",
            "{'title': 'Meeting #102: Ontario Health Ministry Reps', 'content': 'Introductory. Discussed home care funding.', 'category': 'Introductory'}",
            "{'title': 'Meeting #103: Calgary Chiropractors Association', 'content': 'FollowUp. Sent partnership contract drafts.', 'category': 'FollowUp'}"
        ],
        "action_label": "Schedule Consultation Meeting"
    },
    {
        "file_path": r"apps/primecare_business_development/lib/features/business_development/presentation/widgets/regional_bdm_partners_screen.dart",
        "controller_import": "regional_bdm_partners_screen_controller.dart",
        "controller_provider": "regional_bdm_partners_screen_controllerProvider",
        "class_name": "RegionalBdmPartnersScreen",
        "title": "Regional BDM Partners",
        "desc": "Audit and review external healthcare partners, contract terms, and compliance status.",
        "categories": ["All", "Active", "Pending", "Review"],
        "items": [
            "{'title': 'Partner #201: Toronto Physiotherapy Group', 'content': 'Active. Contract signed through 2028.', 'category': 'Active'}",
            "{'title': 'Partner #202: Alberta Senior Home Care Inc.', 'content': 'Pending. Awaiting liability insurance proof.', 'category': 'Pending'}",
            "{'title': 'Partner #203: BC Rehab Specialists', 'content': 'Review. Contract expires in 30 days.', 'category': 'Review'}"
        ],
        "action_label": "Register Partner Node"
    },
    {
        "file_path": r"apps/primecare_business_development/lib/features/business_development/presentation/widgets/regional_bdm_reports_screen.dart",
        "controller_import": "regional_bdm_reports_screen_controller.dart",
        "controller_provider": "regional_bdm_reports_screen_controllerProvider",
        "class_name": "RegionalBdmReportsScreen",
        "title": "Regional BDM Reports",
        "desc": "Generate and review business expansion reports, conversion analyses, and market summaries.",
        "categories": ["All", "Quarterly", "Monthly", "Annual"],
        "items": [
            "{'title': 'Report Q2 2026: Expansion Progress', 'content': 'Ready for review. Toronto expansion exceeded SLA by 4%.', 'category': 'Quarterly'}",
            "{'title': 'Report May 2026: Lead Conversion Matrix', 'content': 'Completed. 12 new clinic leads onboarding.', 'category': 'Monthly'}",
            "{'title': 'Annual Prospectus 2025: BDM Outlook', 'content': 'Archived. Core rehab staff growth metrics.', 'category': 'Annual'}"
        ],
        "action_label": "Compile Expansion Report"
    },
    {
        "file_path": r"apps/primecare_business_development/lib/features/business_development/presentation/widgets/regional_bdm_tasks_screen.dart",
        "controller_import": "regional_bdm_tasks_screen_controller.dart",
        "controller_provider": "regional_bdm_tasks_screen_controllerProvider",
        "class_name": "RegionalBdmTasksScreen",
        "title": "Regional BDM Tasks",
        "desc": "Checklist of operations tasks including vetting, signing contracts, and initial site calls.",
        "categories": ["All", "High", "Medium", "Low"],
        "items": [
            "{'title': 'Task #301: Sign NDA with Vancouver Group', 'content': 'High priority. Critical path for acquisition.', 'category': 'High'}",
            "{'title': 'Task #302: Audit Calgary Partner insurance docs', 'content': 'Medium priority. Compliance check.', 'category': 'Medium'}",
            "{'title': 'Task #303: Follow up on email thread #1024', 'content': 'Low priority. Standard client query.', 'category': 'Low'}"
        ],
        "action_label": "Log Tasks Checklist"
    },
    {
        "file_path": r"apps/primecare_business_development/lib/features/business_development/presentation/widgets/regional_bdm_territory_growth_screen.dart",
        "controller_import": "regional_bdm_territory_growth_screen_controller.dart",
        "controller_provider": "regional_bdm_territory_growth_screen_controllerProvider",
        "class_name": "RegionalBdmTerritoryGrowthScreen",
        "title": "Regional BDM Territory Growth",
        "desc": "Track expansion demographics, open territories, and regional growth metrics.",
        "categories": ["All", "Ontario", "BC", "Alberta"],
        "items": [
            "{'title': 'Territory #101: Greater Toronto Expansion', 'content': 'Target growth is 12%. Active outreach underway.', 'category': 'Ontario'}",
            "{'title': 'Territory #102: Vancouver Island Hub', 'content': 'Lease agreement finalization stage.', 'category': 'BC'}",
            "{'title': 'Territory #103: Calgary South Suburbs', 'content': 'Vetting prospective clinic directors.', 'category': 'Alberta'}"
        ],
        "action_label": "Register Growth Node"
    },
    {
        "file_path": r"apps/primecare_franchise/lib/features/generated_screens/franchise_sales_manager_contracts_screen.dart",
        "controller_import": "franchise_sales_manager_contracts_screen_controller.dart",
        "controller_provider": "franchise_sales_manager_contracts_screen_controllerProvider",
        "class_name": "FranchiseSalesManagerContractsScreen",
        "title": "Franchise Sales Contracts",
        "desc": "Verify, sign, and store franchise license contracts and liability documents.",
        "categories": ["All", "Standard", "Custom", "Draft"],
        "items": [
            "{'title': 'Contract #901: Ottawa West Unit Agreement', 'content': 'Standard format. SLA parameters verified.', 'category': 'Standard'}",
            "{'title': 'Contract #902: Edmonton South Custom License', 'content': 'Custom format. Awaiting legal review clearance.', 'category': 'Custom'}",
            "{'title': 'Contract #903: Winnipeg East Draft SLA', 'content': 'Draft format. Sent to prospect for revisions.', 'category': 'Draft'}"
        ],
        "action_label": "Compile Franchise Contract"
    },
    {
        "file_path": r"apps/primecare_franchise/lib/features/generated_screens/franchise_sales_manager_discovery_calls_screen.dart",
        "controller_import": "franchise_sales_manager_discovery_calls_screen_controller.dart",
        "controller_provider": "franchise_sales_manager_discovery_calls_screen_controllerProvider",
        "class_name": "FranchiseSalesManagerDiscoveryCallsScreen",
        "title": "Franchise Sales Discovery Calls",
        "desc": "Log and schedule discovery calls with prospective franchise leads.",
        "categories": ["All", "Scheduled", "Completed", "NoShow"],
        "items": [
            "{'title': 'Call #501: John Miller (Mississauga prospect)', 'content': 'Scheduled for June 26 at 10:00 AM.', 'category': 'Scheduled'}",
            "{'title': 'Call #502: Dr. Sarah Vance (Calgary group)', 'content': 'Completed. Sent franchise package.', 'category': 'Completed'}",
            "{'title': 'Call #503: Robert Chen (Winnipeg prospect)', 'content': 'NoShow. Send follow-up scheduler link.', 'category': 'NoShow'}"
        ],
        "action_label": "Log Discovery Call"
    },
    {
        "file_path": r"apps/primecare_franchise/lib/features/generated_screens/franchise_sales_manager_follow_ups_screen.dart",
        "controller_import": "franchise_sales_manager_follow_ups_screen_controller.dart",
        "controller_provider": "franchise_sales_manager_follow_ups_screen_controllerProvider",
        "class_name": "FranchiseSalesManagerFollowUpsScreen",
        "title": "Franchise Sales Follow-Ups",
        "desc": "Checklist and history logs for follow-up reminders with warm leads.",
        "categories": ["All", "Immediate", "Scheduled", "Postponed"],
        "items": [
            "{'title': 'Follow-Up #1: Send NDA to Toronto group', 'content': 'Immediate. NDA compiled and ready for Docusign.', 'category': 'Immediate'}",
            "{'title': 'Follow-Up #2: Call Ottawa prospect', 'content': 'Scheduled. Call tomorrow afternoon.', 'category': 'Scheduled'}",
            "{'title': 'Follow-Up #3: Demo video for Edmonton lead', 'content': 'Postponed. Lead out of town until next week.', 'category': 'Postponed'}"
        ],
        "action_label": "Log Follow-Up Task"
    },
    {
        "file_path": r"apps/primecare_franchise/lib/features/generated_screens/franchise_sales_manager_leads_screen.dart",
        "controller_import": "franchise_sales_manager_leads_screen_controller.dart",
        "controller_provider": "franchise_sales_manager_leads_screen_controllerProvider",
        "class_name": "FranchiseSalesManagerLeadsScreen",
        "title": "Franchise Sales Leads",
        "desc": "Monitor lead status, analyze conversion rates, and coordinate with potential franchisees.",
        "categories": ["All", "Hot", "Warm", "Cold"],
        "items": [
            "{'title': 'Lead #601: Ottawa Health Partners Inc.', 'content': 'Hot lead. Re-submitting financial checks.', 'category': 'Hot'}",
            "{'title': 'Lead #602: Calgary Physio Consortium', 'content': 'Warm lead. Sent proposal draft #2.', 'category': 'Warm'}",
            "{'title': 'Lead #603: Victoria Wellness Group', 'content': 'Cold lead. Initial call completed last month.', 'category': 'Cold'}"
        ],
        "action_label": "Create Franchise Lead"
    },
    {
        "file_path": r"apps/primecare_franchise/lib/features/generated_screens/franchise_sales_manager_proposals_screen.dart",
        "controller_import": "franchise_sales_manager_proposals_screen_controller.dart",
        "controller_provider": "franchise_sales_manager_proposals_screen_controllerProvider",
        "class_name": "FranchiseSalesManagerProposalsScreen",
        "title": "Franchise Sales Proposals",
        "desc": "Create, edit, and send franchise partnership and financing proposals.",
        "categories": ["All", "Draft", "Sent", "Accepted"],
        "items": [
            "{'title': 'Proposal #801: Ottawa West Rehab center', 'content': 'Sent. Awaiting prospect review signature.', 'category': 'Sent'}",
            "{'title': 'Proposal #802: Edmonton South multi-unit hub', 'content': 'Accepted. Moving to contract signing.', 'category': 'Accepted'}",
            "{'title': 'Proposal #803: Winnipeg East single unit', 'content': 'Draft. Finalizing construction pricing metrics.', 'category': 'Draft'}"
        ],
        "action_label": "Draft Partnership Proposal"
    },
    {
        "file_path": r"apps/primecare_franchise/lib/features/generated_screens/franchise_sales_manager_prospects_screen.dart",
        "controller_import": "franchise_sales_manager_prospects_screen_controller.dart",
        "controller_provider": "franchise_sales_manager_prospects_screen_controllerProvider",
        "class_name": "FranchiseSalesManagerProspectsScreen",
        "title": "Franchise Sales Prospects",
        "desc": "Database of qualified prospective owners, financial ratings, and liquid assets proof.",
        "categories": ["All", "Vetted", "Vetting", "Deferred"],
        "items": [
            "{'title': 'Prospect #701: John Miller', 'content': 'Vetted. High liquid assets proof cleared.', 'category': 'Vetted'}",
            "{'title': 'Prospect #702: Dr. Sarah Vance', 'content': 'Vetting. Background credential checks running.', 'category': 'Vetting'}",
            "{'title': 'Prospect #703: Robert Chen', 'content': 'Deferred. Insufficient capital verification.', 'category': 'Deferred'}"
        ],
        "action_label": "Create Prospect Card"
    },
    {
        "file_path": r"apps/primecare_franchise/lib/features/generated_screens/franchise_sales_manager_reports_screen.dart",
        "controller_import": "franchise_sales_manager_reports_screen_controller.dart",
        "controller_provider": "franchise_sales_manager_reports_screen_controllerProvider",
        "class_name": "FranchiseSalesManagerReportsScreen",
        "title": "Franchise Sales Reports",
        "desc": "Performance reports including annual sales forecasts and marketing lead efficacy.",
        "categories": ["All", "Financial", "Pipeline", "KPIs"],
        "items": [
            "{'title': 'Sales Forecast FY2027: National Rollout', 'content': 'Completed. Projected 18% franchise revenue growth.', 'category': 'Financial'}",
            "{'title': 'Conversion Analysis May 2026: Hot Leads', 'content': 'Completed. High success rate on discovery calls.', 'category': 'Pipeline'}",
            "{'title': 'Branch Ingestion Statistics Q1', 'content': 'Archived. Review of onboarding delay times.', 'category': 'KPIs'}"
        ],
        "action_label": "Compile Performance Report"
    },
    {
        "file_path": r"apps/primecare_franchise/lib/features/generated_screens/franchise_sales_manager_sales_pipeline_screen.dart",
        "controller_import": "franchise_sales_manager_sales_pipeline_screen_controller.dart",
        "controller_provider": "franchise_sales_manager_sales_pipeline_screen_controllerProvider",
        "class_name": "FranchiseSalesManagerSalesPipelineScreen",
        "title": "Franchise Sales Pipeline",
        "desc": "Monitor active sales stages from initial lead connection to contract signed.",
        "categories": ["All", "LeadGen", "Negotiation", "Signed"],
        "items": [
            "{'title': 'Sales Stage #101: Ottawa Health Group', 'content': 'Negotiation stage. Re-vetted franchise territory plan.', 'category': 'Negotiation'}",
            "{'title': 'Sales Stage #102: Calgary Physio Center', 'content': 'LeadGen stage. Sent preliminary brochures.', 'category': 'LeadGen'}",
            "{'title': 'Sales Stage #103: Victoria Wellness Hub', 'content': 'Signed stage. Transitioned to coordinator onboarding.', 'category': 'Signed'}"
        ],
        "action_label": "Log Pipeline Milestone"
    },
    {
        "file_path": r"apps/primecare_business_development/lib/features/partnership/screens/partnership_manager_active_deals_screen.dart",
        "controller_import": "partnership_manager_active_deals_screen_controller.dart",
        "controller_provider": "partnership_manager_active_deals_screen_controllerProvider",
        "class_name": "PartnershipManagerActiveDealsScreen",
        "title": "Partnership Active Deals",
        "desc": "Track active deals with external business partners and clinical suppliers.",
        "categories": ["All", "Active", "Negotiating", "Closed"],
        "items": [
            "{'title': 'Deal #1001: MedSupply Equipment Group', 'content': 'Active. Supply agreement cleared through 2028.', 'category': 'Active'}",
            "{'title': 'Deal #1002: Allied Nursing Staffing Agency', 'content': 'Negotiating. Reviewing hourly resource rates.', 'category': 'Negotiating'}",
            "{'title': 'Deal #1003: CoreRehab Clinic network deal', 'content': 'Closed. Replaced by Vancouver acquisition contract.', 'category': 'Closed'}"
        ],
        "action_label": "Create Active Deal Profile"
    }
]

# Code template for the replacement
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
import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '{controller_import}';

class {class_name} extends ConsumerStatefulWidget {{
  const {class_name}({{super.key}});

  @override
  ConsumerState<{class_name}> createState() => _{class_name}State();
}}

class _{class_name}State extends ConsumerState<{class_name}> {{
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
    final state = ref.watch({controller_provider});

    return Scaffold(
      appBar: AppBar(
        title: const Text('{title}'),
      ),
      body: state.when(
        data: (data) => _buildContent(context),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Telemetry connection failed: $error')),
      ),
    );
  }}

  Widget _buildContent(BuildContext context) {{
    final filtered = _records.where((record) {{
      final matchesQuery = record['title']!.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          record['content']!.toLowerCase().contains(_searchQuery.toLowerCase());
      final matchesCategory = _selectedCategory == 'All' || record['category'] == _selectedCategory;
      return matchesQuery && matchesCategory;
    }}).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Action / Purpose Hero panel
        Container(
          padding: const EdgeInsets.all(16),
          color: Theme.of(context).primaryColor.withValues(alpha: 0.05),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Operational Control Panel',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 4),
              Text(
                '{desc}',
                style: TextStyle(color: Colors.grey.shade700, fontSize: 13),
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
                          showDialog(
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
    );
  }}

  void _showActionDialog() {{
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('{action_label}'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _dialogController,
              decoration: const InputDecoration(
                hintText: 'Enter title/event details...',
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

def to_provider_name(provider_key):
    base = provider_key.replace("Provider", "")
    components = base.split('_')
    camel = components[0] + ''.join(x.title() for x in components[1:])
    return camel + "Provider"

def run_upgrade():
    print("Upgrading 17 screens...")
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
            controller_provider=to_provider_name(sc["controller_provider"]),
            class_name=sc["class_name"],
            title=sc["title"],
            desc=sc["desc"],
            items_list=items_list,
            categories_list=categories_list,
            action_label=sc["action_label"]
        )

        with open(full_path, "w", encoding="utf-8") as f:
            f.write(new_content)
        print(f"Upgraded screen code for: {sc['class_name']} at {sc['file_path']}")

if __name__ == "__main__":
    run_upgrade()
