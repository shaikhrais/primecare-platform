const fs = require('fs');
const path = require('path');

const APP_DIR = path.join(__dirname, '..', 'apps', 'primecare_business_development');
const ROUTER_FILE = path.join(APP_DIR, 'lib', 'core', 'routing', 'app_router.dart');

console.log('--- STARTING BATCH 13 (BUSINESS DEV) IMPLEMENTATION ---');

const DIRS = [
  'regional', 'bdm', 'sales', 'partnership', 'expansion', 'general'
].map(d => path.join(APP_DIR, 'lib', 'features', d, 'screens'));

DIRS.forEach(dir => {
  if (!fs.existsSync(dir)) fs.mkdirSync(dir, { recursive: true });
});

// 1. Scaffold 38 Screens
const screens = [
  // General / Regional
  { dir: DIRS[0], sub: 'regional', file: 'regional_manager_ontario_dashboard_screen.dart', cls: 'RegionalManagerOntarioDashboardScreen', title: 'Ontario Regional Dashboard', icon: 'Icons.map', route: 'BusinessDevelopmentRoutes.regionalManagerOntarioDashboard', color: 'Colors.blue.shade800' },
  { dir: DIRS[0], sub: 'regional', file: 'regional_manager_usa_dashboard_screen.dart', cls: 'RegionalManagerUsaDashboardScreen', title: 'USA Regional Dashboard', icon: 'Icons.public', route: 'BusinessDevelopmentRoutes.regionalManagerUsaDashboard', color: 'Colors.blue.shade800' },
  { dir: DIRS[5], sub: 'general', file: 'general_manager_dashboard_screen.dart', cls: 'GeneralManagerDashboardScreen', title: 'General Manager Dashboard', icon: 'Icons.business', route: 'BusinessDevelopmentRoutes.generalManagerDashboard', color: 'Colors.blueGrey.shade800' },

  // Regional BDM (10)
  { dir: DIRS[1], sub: 'bdm', file: 'regional_bdm_dashboard_screen.dart', cls: 'RegionalBdmDashboardScreen', title: 'BDM Dashboard', icon: 'Icons.dashboard', route: 'BusinessDevelopmentRoutes.regionalBdmDashboard', color: 'Colors.indigo.shade600' },
  { dir: DIRS[1], sub: 'bdm', file: 'regional_bdm_leads_screen.dart', cls: 'RegionalBdmLeadsScreen', title: 'Leads', icon: 'Icons.person_add', route: 'BusinessDevelopmentRoutes.regionalBdmLeads', color: 'Colors.indigo.shade600' },
  { dir: DIRS[1], sub: 'bdm', file: 'regional_bdm_franchise_pipeline_screen.dart', cls: 'RegionalBdmFranchisePipelineScreen', title: 'Franchise Pipeline', icon: 'Icons.timeline', route: 'BusinessDevelopmentRoutes.regionalBdmFranchisePipeline', color: 'Colors.indigo.shade600' },
  { dir: DIRS[1], sub: 'bdm', file: 'regional_bdm_territory_growth_screen.dart', cls: 'RegionalBdmTerritoryGrowthScreen', title: 'Territory Growth', icon: 'Icons.landscape', route: 'BusinessDevelopmentRoutes.regionalBdmTerritoryGrowth', color: 'Colors.indigo.shade600' },
  { dir: DIRS[1], sub: 'bdm', file: 'regional_bdm_meetings_screen.dart', cls: 'RegionalBdmMeetingsScreen', title: 'Meetings', icon: 'Icons.handshake', route: 'BusinessDevelopmentRoutes.regionalBdmMeetings', color: 'Colors.indigo.shade600' },
  { dir: DIRS[1], sub: 'bdm', file: 'regional_bdm_deal_tracker_screen.dart', cls: 'RegionalBdmDealTrackerScreen', title: 'Deal Tracker', icon: 'Icons.track_changes', route: 'BusinessDevelopmentRoutes.regionalBdmDealTracker', color: 'Colors.indigo.shade600' },
  { dir: DIRS[1], sub: 'bdm', file: 'regional_bdm_partners_screen.dart', cls: 'RegionalBdmPartnersScreen', title: 'Partners', icon: 'Icons.group_work', route: 'BusinessDevelopmentRoutes.regionalBdmPartners', color: 'Colors.indigo.shade600' },
  { dir: DIRS[1], sub: 'bdm', file: 'regional_bdm_competitor_notes_screen.dart', cls: 'RegionalBdmCompetitorNotesScreen', title: 'Competitor Notes', icon: 'Icons.notes', route: 'BusinessDevelopmentRoutes.regionalBdmCompetitorNotes', color: 'Colors.indigo.shade600' },
  { dir: DIRS[1], sub: 'bdm', file: 'regional_bdm_tasks_screen.dart', cls: 'RegionalBdmTasksScreen', title: 'Tasks', icon: 'Icons.task', route: 'BusinessDevelopmentRoutes.regionalBdmTasks', color: 'Colors.indigo.shade600' },
  { dir: DIRS[1], sub: 'bdm', file: 'regional_bdm_reports_screen.dart', cls: 'RegionalBdmReportsScreen', title: 'Reports', icon: 'Icons.bar_chart', route: 'BusinessDevelopmentRoutes.regionalBdmReports', color: 'Colors.indigo.shade600' },

  // Franchise Sales Manager (9)
  { dir: DIRS[2], sub: 'sales', file: 'franchise_sales_manager_dashboard_screen.dart', cls: 'FranchiseSalesManagerDashboardScreen', title: 'Sales Dashboard', icon: 'Icons.point_of_sale', route: 'BusinessDevelopmentRoutes.franchiseSalesManagerDashboard', color: 'Colors.green.shade600' },
  { dir: DIRS[2], sub: 'sales', file: 'franchise_sales_manager_leads_screen.dart', cls: 'FranchiseSalesManagerLeadsScreen', title: 'Leads', icon: 'Icons.recent_actors', route: 'BusinessDevelopmentRoutes.franchiseSalesManagerLeads', color: 'Colors.green.shade600' },
  { dir: DIRS[2], sub: 'sales', file: 'franchise_sales_manager_prospects_screen.dart', cls: 'FranchiseSalesManagerProspectsScreen', title: 'Prospects', icon: 'Icons.search', route: 'BusinessDevelopmentRoutes.franchiseSalesManagerProspects', color: 'Colors.green.shade600' },
  { dir: DIRS[2], sub: 'sales', file: 'franchise_sales_manager_discovery_calls_screen.dart', cls: 'FranchiseSalesManagerDiscoveryCallsScreen', title: 'Discovery Calls', icon: 'Icons.phone', route: 'BusinessDevelopmentRoutes.franchiseSalesManagerDiscoveryCalls', color: 'Colors.green.shade600' },
  { dir: DIRS[2], sub: 'sales', file: 'franchise_sales_manager_proposals_screen.dart', cls: 'FranchiseSalesManagerProposalsScreen', title: 'Proposals', icon: 'Icons.description', route: 'BusinessDevelopmentRoutes.franchiseSalesManagerProposals', color: 'Colors.green.shade600' },
  { dir: DIRS[2], sub: 'sales', file: 'franchise_sales_manager_sales_pipeline_screen.dart', cls: 'FranchiseSalesManagerSalesPipelineScreen', title: 'Sales Pipeline', icon: 'Icons.view_kanban', route: 'BusinessDevelopmentRoutes.franchiseSalesManagerSalesPipeline', color: 'Colors.green.shade600' },
  { dir: DIRS[2], sub: 'sales', file: 'franchise_sales_manager_contracts_screen.dart', cls: 'FranchiseSalesManagerContractsScreen', title: 'Contracts', icon: 'Icons.assignment_turned_in', route: 'BusinessDevelopmentRoutes.franchiseSalesManagerContracts', color: 'Colors.green.shade600' },
  { dir: DIRS[2], sub: 'sales', file: 'franchise_sales_manager_follow_ups_screen.dart', cls: 'FranchiseSalesManagerFollowUpsScreen', title: 'Follow Ups', icon: 'Icons.reply', route: 'BusinessDevelopmentRoutes.franchiseSalesManagerFollowUps', color: 'Colors.green.shade600' },
  { dir: DIRS[2], sub: 'sales', file: 'franchise_sales_manager_reports_screen.dart', cls: 'FranchiseSalesManagerReportsScreen', title: 'Reports', icon: 'Icons.analytics', route: 'BusinessDevelopmentRoutes.franchiseSalesManagerReports', color: 'Colors.green.shade600' },

  // Partnership Manager (7)
  { dir: DIRS[3], sub: 'partnership', file: 'partnership_manager_dashboard_screen.dart', cls: 'PartnershipManagerDashboardScreen', title: 'Partnership Dashboard', icon: 'Icons.domain', route: 'BusinessDevelopmentRoutes.partnershipManagerDashboard', color: 'Colors.purple.shade600' },
  { dir: DIRS[3], sub: 'partnership', file: 'partnership_manager_partners_screen.dart', cls: 'PartnershipManagerPartnersScreen', title: 'Partners', icon: 'Icons.group', route: 'BusinessDevelopmentRoutes.partnershipManagerPartners', color: 'Colors.purple.shade600' },
  { dir: DIRS[3], sub: 'partnership', file: 'partnership_manager_outreach_screen.dart', cls: 'PartnershipManagerOutreachScreen', title: 'Outreach', icon: 'Icons.forward_to_inbox', route: 'BusinessDevelopmentRoutes.partnershipManagerOutreach', color: 'Colors.purple.shade600' },
  { dir: DIRS[3], sub: 'partnership', file: 'partnership_manager_active_deals_screen.dart', cls: 'PartnershipManagerActiveDealsScreen', title: 'Active Deals', icon: 'Icons.work', route: 'BusinessDevelopmentRoutes.partnershipManagerActiveDeals', color: 'Colors.purple.shade600' },
  { dir: DIRS[3], sub: 'partnership', file: 'partnership_manager_proposals_screen.dart', cls: 'PartnershipManagerProposalsScreen', title: 'Proposals', icon: 'Icons.description', route: 'BusinessDevelopmentRoutes.partnershipManagerProposals', color: 'Colors.purple.shade600' },
  { dir: DIRS[3], sub: 'partnership', file: 'partnership_manager_renewals_screen.dart', cls: 'PartnershipManagerRenewalsScreen', title: 'Renewals', icon: 'Icons.autorenew', route: 'BusinessDevelopmentRoutes.partnershipManagerRenewals', color: 'Colors.purple.shade600' },
  { dir: DIRS[3], sub: 'partnership', file: 'partnership_manager_reports_screen.dart', cls: 'PartnershipManagerReportsScreen', title: 'Reports', icon: 'Icons.insert_chart_outlined', route: 'BusinessDevelopmentRoutes.partnershipManagerReports', color: 'Colors.purple.shade600' },

  // Territory Expansion Manager (9)
  { dir: DIRS[4], sub: 'expansion', file: 'territory_expansion_manager_dashboard_screen.dart', cls: 'TerritoryExpansionManagerDashboardScreen', title: 'Expansion Dashboard', icon: 'Icons.map', route: 'BusinessDevelopmentRoutes.territoryExpansionManagerDashboard', color: 'Colors.orange.shade700' },
  { dir: DIRS[4], sub: 'expansion', file: 'territory_expansion_manager_territory_map_screen.dart', cls: 'TerritoryExpansionManagerTerritoryMapScreen', title: 'Territory Map', icon: 'Icons.my_location', route: 'BusinessDevelopmentRoutes.territoryExpansionManagerTerritoryMap', color: 'Colors.orange.shade700' },
  { dir: DIRS[4], sub: 'expansion', file: 'territory_expansion_manager_market_research_screen.dart', cls: 'TerritoryExpansionManagerMarketResearchScreen', title: 'Market Research', icon: 'Icons.search', route: 'BusinessDevelopmentRoutes.territoryExpansionManagerMarketResearch', color: 'Colors.orange.shade700' },
  { dir: DIRS[4], sub: 'expansion', file: 'territory_expansion_manager_demographics_screen.dart', cls: 'TerritoryExpansionManagerDemographicsScreen', title: 'Demographics', icon: 'Icons.people_alt', route: 'BusinessDevelopmentRoutes.territoryExpansionManagerDemographics', color: 'Colors.orange.shade700' },
  { dir: DIRS[4], sub: 'expansion', file: 'territory_expansion_manager_open_territories_screen.dart', cls: 'TerritoryExpansionManagerOpenTerritoriesScreen', title: 'Open Territories', icon: 'Icons.add_location_alt', route: 'BusinessDevelopmentRoutes.territoryExpansionManagerOpenTerritories', color: 'Colors.orange.shade700' },
  { dir: DIRS[4], sub: 'expansion', file: 'territory_expansion_manager_expansion_plans_screen.dart', cls: 'TerritoryExpansionManagerExpansionPlansScreen', title: 'Expansion Plans', icon: 'Icons.next_plan', route: 'BusinessDevelopmentRoutes.territoryExpansionManagerExpansionPlans', color: 'Colors.orange.shade700' },
  { dir: DIRS[4], sub: 'expansion', file: 'territory_expansion_manager_site_selection_screen.dart', cls: 'TerritoryExpansionManagerSiteSelectionScreen', title: 'Site Selection', icon: 'Icons.apartment', route: 'BusinessDevelopmentRoutes.territoryExpansionManagerSiteSelection', color: 'Colors.orange.shade700' },
  { dir: DIRS[4], sub: 'expansion', file: 'territory_expansion_manager_forecast_screen.dart', cls: 'TerritoryExpansionManagerForecastScreen', title: 'Forecast', icon: 'Icons.trending_up', route: 'BusinessDevelopmentRoutes.territoryExpansionManagerForecast', color: 'Colors.orange.shade700' },
  { dir: DIRS[4], sub: 'expansion', file: 'territory_expansion_manager_reports_screen.dart', cls: 'TerritoryExpansionManagerReportsScreen', title: 'Reports', icon: 'Icons.bar_chart', route: 'BusinessDevelopmentRoutes.territoryExpansionManagerReports', color: 'Colors.orange.shade700' },
];

let importStatements = '';
let routeStatements = '';
let hideClasses = [];

const buildScreen = (s) => `
import 'package:flutter/material.dart';

class ${s.cls} extends StatelessWidget {
  const ${s.cls}({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(${s.icon}, size: 40, color: ${s.color}),
                const SizedBox(width: 16),
                Text("${s.title}", style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: ${s.color})),
              ],
            ),
            const SizedBox(height: 30),
            Expanded(
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(${s.icon}, size: 80, color: Colors.grey),
                      const SizedBox(height: 16),
                      Text("${s.title} actively running.", style: const TextStyle(fontSize: 20, color: Colors.black54)),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
`;

screens.forEach(s => {
  fs.writeFileSync(path.join(s.dir, s.file), buildScreen(s).trim());
  importStatements += `import '../../features/${s.sub}/screens/${s.file}';\n`;
  routeStatements += `      GoRoute(path: ${s.route}, builder: (context, state) => const ${s.cls}()),\n`;
  hideClasses.push(s.cls);
});

console.log('✅ 38 BusDev Screens scaffolded.');

// 2. Inject Routes into app_router.dart
if (fs.existsSync(ROUTER_FILE)) {
    let content = fs.readFileSync(ROUTER_FILE, 'utf8');
    
    // Inject hide classes into the existing primecare_ui import
    const hideString = "hide " + hideClasses.join(", ") + ", ";
    if (content.includes("import 'package:primecare_ui/primecare_ui.dart';")) {
        content = content.replace("import 'package:primecare_ui/primecare_ui.dart';", "import 'package:primecare_ui/primecare_ui.dart' " + hideString + ";\n" + importStatements);
    } else if (content.includes("hide ")) {
        content = content.replace("hide ", hideString);
        content = content.replace("import 'business_development_routes.dart';", "import 'business_development_routes.dart';\n" + importStatements);
    } else {
        content = content.replace("import 'business_development_routes.dart';", "import 'package:primecare_ui/primecare_ui.dart' " + hideString + ";\nimport 'business_development_routes.dart';\n" + importStatements);
    }
    
    // Inject the exact explicit routes right into publicRoutes
    if (!content.includes(screens[0].cls)) {
        if (content.includes("publicRoutes: [")) {
            content = content.replace(
                "publicRoutes: [", 
                "publicRoutes: [\n" + routeStatements
            );
        } else {
             // Sometimes it might not have publicRoutes if it's identical to the base GovernanceRouter, let's just make sure.
             content = content.replace("    redirect: ", "    publicRoutes: [\n" + routeStatements + "    ],\n    redirect: ");
        }
    }

    fs.writeFileSync(ROUTER_FILE, content, 'utf8');
    console.log('✅ Batch 13 Routes injected and collisions hidden.');
} else {
    console.log('❌ ROUTER NOT FOUND: ' + ROUTER_FILE);
}

// 3. Trigger Build & Deploy independently
console.log('--- STARTING BACKGROUND DEPLOYMENT FOR BATCH 13 ---');
try {
    require('child_process').exec('flutter build web --release && npx wrangler pages deploy build/web --project-name primecare-business-development --commit-dirty=true', { cwd: APP_DIR });
    console.log('🏆 Batch 13 Deployment triggered in the background!');
} catch (e) {
    console.error('❌ Failed to trigger deployment!', e.message);
}
