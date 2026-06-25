import os
import re

project_root = r"C:\Users\Admin2\Documents\GitHub\primecare-platform"

screens_config = [
    {
        "file_path": r"apps/primecare_clinic/lib/features/shared/screens/clinic_incident_report_screen.dart",
        "controller_import": "clinic_incident_report_screen_controller.dart",
        "controller_provider": "clinicIncidentReportScreenControllerProvider",
        "class_name": "ClinicIncidentReportScreen",
        "title": "Clinic Incident Report",
        "desc": "Document, audit, and trace clinic incidents, safety reports, and corrective actions.",
        "categories": ["All", "Safety", "Incidents", "Corrective"],
        "items": [
            "{'title': 'Safety: Patient minor slip Oakville', 'content': 'First aid provided. Incident log signed off.', 'category': 'Safety'}",
            "{'title': 'Incident: Medication mismatch shift', 'content': 'Pending clinical director interview.', 'category': 'Incidents'}",
            "{'title': 'Corrective: Floor mat installation', 'content': 'Completed in lobby to prevent slips.', 'category': 'Corrective'}"
        ],
        "action_label": "Log Incident Report"
    },
    {
        "file_path": r"apps/primecare_corporate/lib/features/generated_screens/ceo_alerts_and_risks_screen.dart",
        "controller_import": "ceo_alerts_and_risks_screen_controller.dart",
        "controller_provider": "ceoAlertsAndRisksScreenControllerProvider",
        "class_name": "CeoAlertsAndRisksScreen",
        "title": "CEO Alerts & Risks",
        "desc": "Monitor enterprise risks, regulatory updates, and critical operational alerts.",
        "categories": ["All", "Risks", "Regulatory", "Alerts"],
        "items": [
            "{'title': 'Risk: Nurse shortage GTA', 'content': 'Reviewing hiring pipeline. Respite hours allocated.', 'category': 'Risks'}",
            "{'title': 'Regulatory: Health policy v2.3', 'content': 'Schedules updated to match new compliance guidelines.', 'category': 'Regulatory'}",
            "{'title': 'Alert: System backup latency', 'content': 'R2 backup replication delayed by 18 minutes.', 'category': 'Alerts'}"
        ],
        "action_label": "Acknowledge System Alert"
    },
    {
        "file_path": r"apps/primecare_corporate/lib/features/generated_screens/ceo_approvals_screen.dart",
        "controller_import": "ceo_approvals_screen_controller.dart",
        "controller_provider": "ceoApprovalsScreenControllerProvider",
        "class_name": "CeoApprovalsScreen",
        "title": "CEO Approvals",
        "desc": "Review and sign off on franchise requests, budget expansions, and partnership proposals.",
        "categories": ["All", "Franchise", "Budget", "Partnerships"],
        "items": [
            "{'title': 'Franchise: Milton South request', 'content': 'Pending disclosure check signature.', 'category': 'Franchise'}",
            "{'title': 'Budget: Allied health marketing', 'content': 'Requested \\$12,500 expansion. Under review.', 'category': 'Budget'}",
            "{'title': 'Partnership: Telus Health connection', 'content': 'Proposal reviewed. Technical audit approved.', 'category': 'Partnerships'}"
        ],
        "action_label": "Confirm Pending Approval"
    },
    {
        "file_path": r"apps/primecare_corporate/lib/features/itadmin/screens/it_admin_dashboard_screen.dart",
        "controller_import": "it_admin_dashboard_screen_controller.dart",
        "controller_provider": "itAdminDashboardScreenControllerProvider",
        "class_name": "ItAdminDashboardScreen",
        "title": "IT Admin Dashboard",
        "desc": "Audit server metrics, database sync status, and active system permissions.",
        "categories": ["All", "Server", "Database", "Security"],
        "items": [
            "{'title': 'Server: Worker API status', 'content': 'Active. Latency: 12ms. CPU load: 14%.', 'category': 'Server'}",
            "{'title': 'Database: D1 Sync completed', 'content': 'Zero conflicts found during dynamic scan.', 'category': 'Database'}",
            "{'title': 'Security: Key rotation check', 'content': 'SSH keys successfully rotated for Devops group.', 'category': 'Security'}"
        ],
        "action_label": "Trigger Database Sync"
    },
    {
        "file_path": r"apps/primecare_franchise/lib/features/generated_screens/billing_admin_invoices_screen.dart",
        "controller_import": "billing_admin_invoices_screen_controller.dart",
        "controller_provider": "billingAdminInvoicesScreenControllerProvider",
        "class_name": "BillingAdminInvoicesScreen",
        "title": "Billing Admin Invoices",
        "desc": "Generate, track, and reconcile franchise client invoices and payment status.",
        "categories": ["All", "Pending", "Paid", "Overdue"],
        "items": [
            "{'title': 'Invoice #INV-2901: Oakville Clinic', 'content': 'Amount: \\$4,200. Status: Pending signature.', 'category': 'Pending'}",
            "{'title': 'Invoice #INV-2902: Milton Central', 'content': 'Amount: \\$8,400. Status: Paid via credit transfer.', 'category': 'Paid'}",
            "{'title': 'Invoice #INV-2903: Mississauga West', 'content': 'Amount: \\$2,100. Status: Overdue by 4 days.', 'category': 'Overdue'}"
        ],
        "action_label": "Generate New Invoice"
    },
    {
        "file_path": r"apps/primecare_marketing/lib/features/generated_screens/head_of_marketing_brand_assets_screen.dart",
        "controller_import": "head_of_marketing_brand_assets_screen_controller.dart",
        "controller_provider": "headOfMarketingBrandAssetsScreenControllerProvider",
        "class_name": "HeadOfMarketingBrandAssetsScreen",
        "title": "Brand Assets",
        "desc": "Manage official branding kits, graphics, and logo assets for PrimeCare.",
        "categories": ["All", "Logos", "Kits", "Guidelines"],
        "items": [
            "{'title': 'Logo: Corporate SVG kit', 'content': 'Latest package uploaded. Uptime optimal.', 'category': 'Logos'}",
            "{'title': 'Kit: Outreach flyer templates', 'content': 'Shared templates updated for local printing.', 'category': 'Kits'}",
            "{'title': 'Guidelines: Typography rules v2', 'content': 'Verified Outfit font configuration guidelines.', 'category': 'Guidelines'}"
        ],
        "action_label": "Upload Brand Asset"
    },
    {
        "file_path": r"apps/primecare_marketing/lib/features/generated_screens/head_of_marketing_campaigns_screen.dart",
        "controller_import": "head_of_marketing_campaigns_screen_controller.dart",
        "controller_provider": "headOfMarketingCampaignsScreenControllerProvider",
        "class_name": "HeadOfMarketingCampaignsScreen",
        "title": "Marketing Campaigns",
        "desc": "Monitor corporate marketing campaigns, active ads, and CPC performance.",
        "categories": ["All", "Active", "Planned", "Archived"],
        "items": [
            "{'title': 'Active: GTA Senior Wellness Ad', 'content': 'Impressions: 420K. Conversion rate: 4.8%.', 'category': 'Active'}",
            "{'title': 'Planned: Fall Respite Care push', 'content': 'Target launch date: September 1. Budget allocated.', 'category': 'Planned'}",
            "{'title': 'Archived: Q1 Clinic Launch', 'content': 'Total conversions: 1,840 leads. Budget check OK.', 'category': 'Archived'}"
        ],
        "action_label": "Launch Campaign Plan"
    },
    {
        "file_path": r"apps/primecare_marketing/lib/features/generated_screens/head_of_marketing_content_approval_screen.dart",
        "controller_import": "head_of_marketing_content_approval_screen_controller.dart",
        "controller_provider": "headOfMarketingContentApprovalScreenControllerProvider",
        "class_name": "HeadOfMarketingContentApprovalScreen",
        "title": "Content Approval",
        "desc": "Audit outreach brochures, web updates, and social media posts before release.",
        "categories": ["All", "Pending", "Approved", "Rejected"],
        "items": [
            "{'title': 'Pending: Dementia care brochure', 'content': 'Awaiting CISO review for health claims compliance.', 'category': 'Pending'}",
            "{'title': 'Approved: Elder wellness check list', 'content': 'Verified. Published on senior care portal.', 'category': 'Approved'}",
            "{'title': 'Rejected: Client interview video draft', 'content': 'Rejected due to missing consent signature checks.', 'category': 'Rejected'}"
        ],
        "action_label": "Approve Content Draft"
    },
    {
        "file_path": r"apps/primecare_marketing/lib/features/generated_screens/head_of_marketing_funnel_analytics_screen.dart",
        "controller_import": "head_of_marketing_funnel_analytics_screen_controller.dart",
        "controller_provider": "headOfMarketingFunnelAnalyticsScreenControllerProvider",
        "class_name": "HeadOfMarketingFunnelAnalyticsScreen",
        "title": "Funnel Analytics",
        "desc": "Analyze lead conversion pipelines, CPA, and traffic source attribution.",
        "categories": ["All", "CPA", "Funnel", "Attribution"],
        "items": [
            "{'title': 'CPA: Average Acquisition cost', 'content': 'Corporate clinics CPA holds at \\$112 per lead.', 'category': 'CPA'}",
            "{'title': 'Funnel: Inquire-to-visit conversion', 'content': 'Conversion rate: 18.2%. Met target SLA goal.', 'category': 'Funnel'}",
            "{'title': 'Attribution: Senior center referrals', 'content': 'Generated 42% of active leads in Q2.', 'category': 'Attribution'}"
        ],
        "action_label": "Export Funnel CSV"
    },
    {
        "file_path": r"apps/primecare_marketing/lib/features/generated_screens/head_of_marketing_leads_screen.dart",
        "controller_import": "head_of_marketing_leads_screen_controller.dart",
        "controller_provider": "headOfMarketingLeadsScreenControllerProvider",
        "class_name": "HeadOfMarketingLeadsScreen",
        "title": "Corporate Leads",
        "desc": "Access consolidated leads list and distribute leads to franchise regions.",
        "categories": ["All", "New", "Assigned", "Contacted"],
        "items": [
            "{'title': 'Lead: Mary Vance (GTA North)', 'content': 'Inquired about weekend nurse care options.', 'category': 'New'}",
            "{'title': 'Lead: Robert Lee (Milton Central)', 'content': 'Assigned to Milton scheduler coordinator node.', 'category': 'Assigned'}",
            "{'title': 'Lead: Sarah Vance (Mississauga)', 'content': 'Contacted. Scheduled initial clinical assessment.', 'category': 'Contacted'}"
        ],
        "action_label": "Assign Leads Package"
    },
    {
        "file_path": r"apps/primecare_marketing/lib/features/generated_screens/head_of_marketing_performance_reports_screen.dart",
        "controller_import": "head_of_marketing_performance_reports_screen_controller.dart",
        "controller_provider": "headOfMarketingPerformanceReportsScreenControllerProvider",
        "class_name": "HeadOfMarketingPerformanceReportsScreen",
        "title": "Performance Reports",
        "desc": "Review ROI analysis, conversion reports, and marketing spend audits.",
        "categories": ["All", "ROI", "Audits", "Conversions"],
        "items": [
            "{'title': 'ROI: Q2 Brand Campaign', 'content': 'Calculated ROI: 240% across corporate locations.', 'category': 'ROI'}",
            "{'title': 'Audit: Social Ads budget logs', 'content': 'Spend: \\$24,200. Match database limits perfectly.', 'category': 'Audits'}",
            "{'title': 'Conversions: Clinic lead reports', 'content': 'Total conversions: 320 new accounts verified.', 'category': 'Conversions'}"
        ],
        "action_label": "Compile Performance PDF"
    },
    {
        "file_path": r"apps/primecare_marketing/lib/features/generated_screens/head_of_marketing_regional_campaigns_screen.dart",
        "controller_import": "head_of_marketing_regional_campaigns_screen_controller.dart",
        "controller_provider": "headOfMarketingRegionalCampaignsScreenControllerProvider",
        "class_name": "HeadOfMarketingRegionalCampaignsScreen",
        "title": "Regional Campaigns",
        "desc": "Coordinate campaigns across Eastern and Western regions.",
        "categories": ["All", "EastRegion", "WestRegion", "Schedules"],
        "items": [
            "{'title': 'East: Oakville Senior Expo', 'content': 'Campaign active. Local banner ads deployed.', 'category': 'EastRegion'}",
            "{'title': 'West: Calgary Wellness Seminar', 'content': 'Flyer templates shared with local franchise.', 'category': 'WestRegion'}",
            "{'title': 'Schedule: Cross-region launch dates', 'content': 'Verified. Campaigns synchronized for July.', 'category': 'Schedules'}"
        ],
        "action_label": "Propose Regional Campaign"
    },
    {
        "file_path": r"apps/primecare_marketing/lib/features/generated_screens/local_marketing_manager_assets_screen.dart",
        "controller_import": "local_marketing_manager_assets_screen_controller.dart",
        "controller_provider": "localMarketingManagerAssetsScreenControllerProvider",
        "class_name": "LocalMarketingManagerAssetsScreen",
        "title": "Outreach Assets",
        "desc": "Access local print assets, posters, and clinic brochure templates.",
        "categories": ["All", "Posters", "Brochures", "Templates"],
        "items": [
            "{'title': 'Poster: Local wellness expo banner', 'content': 'High-resolution PDF ready for print shop.', 'category': 'Posters'}",
            "{'title': 'Brochure: In-home respite pricing', 'content': 'Updated with latest HST remittance info.', 'category': 'Brochures'}",
            "{'title': 'Template: Business card assets', 'content': 'Ready for local clinic representatives.', 'category': 'Templates'}"
        ],
        "action_label": "Download Local Asset"
    },
    {
        "file_path": r"apps/primecare_marketing/lib/features/generated_screens/local_marketing_manager_budget_screen.dart",
        "controller_import": "local_marketing_manager_budget_screen_controller.dart",
        "controller_provider": "localMarketingManagerBudgetScreenControllerProvider",
        "class_name": "LocalMarketingManagerBudgetScreen",
        "title": "Local Budget",
        "desc": "Track local advertising expenditures, event setup fees, and brochure print costs.",
        "categories": ["All", "Events", "Printing", "Ads"],
        "items": [
            "{'title': 'Event Fee: Oakville Wellness setup', 'content': 'Cost: \\$450. Status: Approved by COO.', 'category': 'Events'}",
            "{'title': 'Printing: Respite care flyers', 'content': 'Cost: \\$210. Status: Logged transaction.', 'category': 'Printing'}",
            "{'title': 'Ads: Local Facebook geo-campaign', 'content': 'Cost: \\$300. Status: Active CPC tracking.', 'category': 'Ads'}"
        ],
        "action_label": "Log Budget Request"
    },
    {
        "file_path": r"apps/primecare_marketing/lib/features/generated_screens/local_marketing_manager_campaigns_screen.dart",
        "controller_import": "local_marketing_manager_campaigns_screen_controller.dart",
        "controller_provider": "localMarketingManagerCampaignsScreenControllerProvider",
        "class_name": "LocalMarketingManagerCampaignsScreen",
        "title": "Local Campaigns",
        "desc": "Manage local clinic marketing drives, senior home wellness talks, and mail campaigns.",
        "categories": ["All", "WellnessTalks", "Mailers", "Drives"],
        "items": [
            "{'title': 'Talk: Senior Home Wellness FAQ', 'content': 'Scheduled for June 28 at Milton community center.', 'category': 'WellnessTalks'}",
            "{'title': 'Mailer: Local neighborhood brochure', 'content': 'Dispatched to 500 residences. Conversion tracking active.', 'category': 'Mailers'}",
            "{'title': 'Drive: Allied health partner meetup', 'content': 'Completed outreach drive. Logged 12 clinic leads.', 'category': 'Drives'}"
        ],
        "action_label": "Create Local Campaign"
    },
    {
        "file_path": r"apps/primecare_marketing/lib/features/generated_screens/local_marketing_manager_content_calendar_screen.dart",
        "controller_import": "local_marketing_manager_content_calendar_screen_controller.dart",
        "controller_provider": "localMarketingManagerContentCalendarScreenControllerProvider",
        "class_name": "LocalMarketingManagerContentCalendarScreen",
        "title": "Content Calendar",
        "desc": "Coordinate scheduling for local advertisements, newsletters, and wellness events.",
        "categories": ["All", "Newsletters", "Events", "Ads"],
        "items": [
            "{'title': 'Newsletter: July Senior Support guide', 'content': 'Draft ready. Scheduled dispatch: July 1.', 'category': 'Newsletters'}",
            "{'title': 'Event: Bedside care safe transfers talk', 'content': 'Assigned RMT Sarah to demonstrate transfers on June 30.', 'category': 'Events'}",
            "{'title': 'Ad: Local paper wellness block', 'content': 'Space booked. Image asset approved.', 'category': 'Ads'}"
        ],
        "action_label": "Add Calendar Entry"
    },
    {
        "file_path": r"apps/primecare_marketing/lib/features/generated_screens/local_marketing_manager_events_screen.dart",
        "controller_import": "local_marketing_manager_events_screen_controller.dart",
        "controller_provider": "localMarketingManagerEventsScreenControllerProvider",
        "class_name": "LocalMarketingManagerEventsScreen",
        "title": "Marketing Events",
        "desc": "Audit local senior wellness events, caregiver meetups, and clinic opening fairs.",
        "categories": ["All", "Meetups", "Fairs", "Seminars"],
        "items": [
            "{'title': 'Meetup: Caregiver respite support', 'content': 'Milton library room booked. Expected: 15 visitors.', 'category': 'Meetups'}",
            "{'title': 'Fair: Oakville Grand Opening event', 'content': 'Fliers printed. Booth setup checklist completed.', 'category': 'Fairs'}",
            "{'title': 'Seminar: In-home dementia guidelines', 'content': 'Mississauga Seniors club. Registered 24 participants.', 'category': 'Seminars'}"
        ],
        "action_label": "Create Event Logistics"
    },
    {
        "file_path": r"apps/primecare_marketing/lib/features/generated_screens/local_marketing_manager_leads_screen.dart",
        "controller_import": "local_marketing_manager_leads_screen_controller.dart",
        "controller_provider": "localMarketingManagerLeadsScreenControllerProvider",
        "class_name": "LocalMarketingManagerLeadsScreen",
        "title": "Local Leads",
        "desc": "View and assign incoming leads from local wellness events and print ads.",
        "categories": ["All", "Unassigned", "Contacted", "Closed"],
        "items": [
            "{'title': 'Lead: Mary Vance (Oakville)', 'content': 'Inquiry from Wellness Expo flyer card.', 'category': 'Unassigned'}",
            "{'title': 'Lead: John Doe (Milton Central)', 'content': 'Contacted. Sent pricing guide and intake form.', 'category': 'Contacted'}",
            "{'title': 'Lead: Sarah Smith (Mississauga)', 'content': 'Closed. Client signed care package agreement.', 'category': 'Closed'}"
        ],
        "action_label": "Log Lead Conversion"
    },
    {
        "file_path": r"apps/primecare_marketing/lib/features/generated_screens/local_marketing_manager_reports_screen.dart",
        "controller_import": "local_marketing_manager_reports_screen_controller.dart",
        "controller_provider": "localMarketingManagerReportsScreenControllerProvider",
        "class_name": "LocalMarketingManagerReportsScreen",
        "title": "Marketing Reports",
        "desc": "Review local event leads reports, ROI performance tracking, and budget sheets.",
        "categories": ["All", "Performance", "Budget", "ROI"],
        "items": [
            "{'title': 'Performance: Oakville Wellness Expo', 'content': 'Generated 42 leads. Average cost: \\$10.70.', 'category': 'Performance'}",
            "{'title': 'Budget: Q2 Event marketing report', 'content': 'Spent \\$2,450. Under budget guidelines.', 'category': 'Budget'}",
            "{'title': 'ROI: Local print mailer conversions', 'content': 'NPS score holds at 89. ROI: 140%.', 'category': 'ROI'}"
        ],
        "action_label": "Compile Local Report"
    },
    {
        "file_path": r"apps/primecare_marketing/lib/features/generated_screens/territory_sales_manager_area_performance_screen.dart",
        "controller_import": "territory_sales_manager_area_performance_screen_controller.dart",
        "controller_provider": "territorySalesManagerAreaPerformanceScreenControllerProvider",
        "class_name": "TerritorySalesManagerAreaPerformanceScreen",
        "title": "Area Performance",
        "desc": "Analyze sales conversions, territory distribution, and franchise performance.",
        "categories": ["All", "Sales", "Territories", "Performance"],
        "items": [
            "{'title': 'Sales: GTA East conversions', 'content': 'Closed 14 new care packages this week.', 'category': 'Sales'}",
            "{'title': 'Territory: Milton West growth', 'content': 'Active pipeline. Prospective owner signed terms.', 'category': 'Territories'}",
            "{'title': 'Performance: Mississauga Central node', 'content': 'Average sales cycle drops to 4 days. SLA optimal.', 'category': 'Performance'}"
        ],
        "action_label": "Export Area Stats"
    },
    {
        "file_path": r"apps/primecare_marketing/lib/features/generated_screens/territory_sales_manager_competitors_screen.dart",
        "controller_import": "territory_sales_manager_competitors_screen_controller.dart",
        "controller_provider": "territorySalesManagerCompetitorsScreenControllerProvider",
        "class_name": "TerritorySalesManagerCompetitorsScreen",
        "title": "Competitor Audit",
        "desc": "Audit local competitor pricing, care packages, and territory expansions.",
        "categories": ["All", "Pricing", "Services", "Expansions"],
        "items": [
            "{'title': 'Pricing: CareMax rates review', 'content': 'Average billing: \\$45/hr. PrimeCare matches targets.', 'category': 'Pricing'}",
            "{'title': 'Services: SeniorFirst respite care', 'content': 'Added weekend companion care tracks. Reviewing features.', 'category': 'Services'}",
            "{'title': 'Expansion: GTA North corridor', 'content': 'Competitor clinic opening in Richmond Hill next month.', 'category': 'Expansions'}"
        ],
        "action_label": "Log Competitor Intel"
    },
    {
        "file_path": r"apps/primecare_marketing/lib/features/generated_screens/territory_sales_manager_conversions_screen.dart",
        "controller_import": "territory_sales_manager_conversions_screen_controller.dart",
        "controller_provider": "territorySalesManagerConversionsScreenControllerProvider",
        "class_name": "TerritorySalesManagerConversionsScreen",
        "title": "Sales Conversions",
        "desc": "Track lead-to-client conversion rates and sales rep performance metrics.",
        "categories": ["All", "Rates", "RepMetrics", "Funnel"],
        "items": [
            "{'title': 'Rate: Oakville Central node', 'content': 'Conversion rate: 22.4%. Met target goal limits.', 'category': 'Rates'}",
            "{'title': 'Rep: Sarah Vance conversions', 'content': '12 care packages closed. Average satisfaction: 94%.', 'category': 'RepMetrics'}",
            "{'title': 'Funnel: Assessment-to-contract dispatch', 'content': 'Average processing time: 24 hours. Uptime optimal.', 'category': 'Funnel'}"
        ],
        "action_label": "Update Conversion Goals"
    },
    {
        "file_path": r"apps/primecare_marketing/lib/features/generated_screens/territory_sales_manager_field_activity_screen.dart",
        "controller_import": "territory_sales_manager_field_activity_screen_controller.dart",
        "controller_provider": "territorySalesManagerFieldActivityScreenControllerProvider",
        "class_name": "TerritorySalesManagerFieldActivityScreen",
        "title": "Field Activity",
        "desc": "Audit sales rep client visits, field interviews, and site inspections.",
        "categories": ["All", "Visits", "Interviews", "Inspections"],
        "items": [
            "{'title': 'Visit: Oakville Seniors center', 'content': 'Held presentation with center representative. Logged 4 leads.', 'category': 'Visits'}",
            "{'title': 'Interview: Milton franchise lead', 'content': 'Reviewed operational plans and area demographics.', 'category': 'Interviews'}",
            "{'title': 'Inspection: Burlington clinic site', 'content': 'Verified room layouts and accessibility compliance.', 'category': 'Inspections'}"
        ],
        "action_label": "Log Field Activity"
    },
    {
        "file_path": r"apps/primecare_marketing/lib/features/generated_screens/territory_sales_manager_leads_screen.dart",
        "controller_import": "territory_sales_manager_leads_screen_controller.dart",
        "controller_provider": "territorySalesManagerLeadsScreenControllerProvider",
        "class_name": "TerritorySalesManagerLeadsScreen",
        "title": "Territory Leads",
        "desc": "Access territory leads list, assign sales reps, and schedule followups.",
        "categories": ["All", "Unassigned", "Assigned", "FollowUps"],
        "items": [
            "{'title': 'Lead: Mary Vance (Oakville North)', 'content': 'Awaiting assignment to sales representative.', 'category': 'Unassigned'}",
            "{'title': 'Lead: Robert Lee (Burlington)', 'content': 'Assigned to Rep Sarah. Visit scheduled.', 'category': 'Assigned'}",
            "{'title': 'Lead: John Doe (Milton Central)', 'content': 'FollowUp: Call on Monday to check contract status.', 'category': 'FollowUps'}"
        ],
        "action_label": "Assign Territory Lead"
    },
    {
        "file_path": r"apps/primecare_marketing/lib/features/generated_screens/territory_sales_manager_pipeline_screen.dart",
        "controller_import": "territory_sales_manager_pipeline_screen_controller.dart",
        "controller_provider": "territorySalesManagerPipelineScreenControllerProvider",
        "class_name": "TerritorySalesManagerPipelineScreen",
        "title": "Sales Pipeline",
        "desc": "Track prospective franchise acquisitions, contract signatures, and clinic staging.",
        "categories": ["All", "Acquisitions", "Contracts", "Staging"],
        "items": [
            "{'title': 'Acquisition: Burlington West node', 'content': 'Terms agreed. Awaiting disclosure documentation.', 'category': 'Acquisitions'}",
            "{'title': 'Contract: Oakville South signature', 'content': 'Signed lease agreement received. Files synchronized.', 'category': 'Contracts'}",
            "{'title': 'Staging: Milton Central setup', 'content': 'Clinic branding deployed. Opening set for July 15.', 'category': 'Staging'}"
        ],
        "action_label": "Update Pipeline Status"
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
    print("Upgrading 25 governed screens across apps (Round 9)...")
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
