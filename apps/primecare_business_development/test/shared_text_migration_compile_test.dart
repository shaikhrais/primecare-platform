// Compile smoke coverage for constructor-only shared text migration.
// This does not claim individual screen runtime acceptance.
import 'package:flutter_test/flutter_test.dart';
import 'package:primecare_business_development/features/business_development/presentation/widgets/regional_bdm_competitor_notes_screen.dart' as migrated0;
import 'package:primecare_business_development/features/business_development/presentation/widgets/regional_bdm_deal_tracker_screen.dart' as migrated1;
import 'package:primecare_business_development/features/business_development/presentation/widgets/regional_bdm_leads_screen.dart' as migrated2;
import 'package:primecare_business_development/features/business_development/presentation/widgets/regional_bdm_meetings_screen.dart' as migrated3;
import 'package:primecare_business_development/features/business_development/presentation/widgets/regional_bdm_partners_screen.dart' as migrated4;
import 'package:primecare_business_development/features/business_development/presentation/widgets/regional_bdm_reports_screen.dart' as migrated5;
import 'package:primecare_business_development/features/business_development/presentation/widgets/regional_bdm_tasks_screen.dart' as migrated6;
import 'package:primecare_business_development/features/business_development/presentation/widgets/regional_bdm_territory_growth_screen.dart' as migrated7;
import 'package:primecare_business_development/features/expansion/screens/territory_expansion_manager_demographics_screen.dart' as migrated8;
import 'package:primecare_business_development/features/expansion/screens/territory_expansion_manager_expansion_plans_screen.dart' as migrated9;
import 'package:primecare_business_development/features/expansion/screens/territory_expansion_manager_forecast_screen.dart' as migrated10;
import 'package:primecare_business_development/features/expansion/screens/territory_expansion_manager_market_research_screen.dart' as migrated11;
import 'package:primecare_business_development/features/expansion/screens/territory_expansion_manager_open_territories_screen.dart' as migrated12;
import 'package:primecare_business_development/features/expansion/screens/territory_expansion_manager_reports_screen.dart' as migrated13;
import 'package:primecare_business_development/features/expansion/screens/territory_expansion_manager_site_selection_screen.dart' as migrated14;
import 'package:primecare_business_development/features/expansion/screens/territory_expansion_manager_territory_map_screen.dart' as migrated15;
import 'package:primecare_business_development/features/partnership/screens/partnership_manager_active_deals_screen.dart' as migrated16;
import 'package:primecare_business_development/features/partnership/screens/partnership_manager_outreach_screen.dart' as migrated17;
import 'package:primecare_business_development/features/partnership/screens/partnership_manager_partners_screen.dart' as migrated18;
import 'package:primecare_business_development/features/partnership/screens/partnership_manager_proposals_screen.dart' as migrated19;
import 'package:primecare_business_development/features/partnership/screens/partnership_manager_renewals_screen.dart' as migrated20;
import 'package:primecare_business_development/features/partnership/screens/partnership_manager_reports_screen.dart' as migrated21;
import 'package:primecare_business_development/features/regional/screens/regional_manager_ontario_dashboard_screen.dart' as migrated22;

void main() {
  test('migrated consumer libraries compile', () {
    const migratedTypes = <Type>[
    migrated0.RegionalBdmCompetitorNotesScreenState,
    migrated1.RegionalBdmDealTrackerScreenState,
    migrated2.RegionalBdmLeadsScreenState,
    migrated3.RegionalBdmMeetingsScreenState,
    migrated4.RegionalBdmPartnersScreenState,
    migrated5.RegionalBdmReportsScreenState,
    migrated6.RegionalBdmTasksScreenState,
    migrated7.RegionalBdmTerritoryGrowthScreenState,
    migrated8.TerritoryExpansionManagerDemographicsScreenState,
    migrated9.TerritoryExpansionManagerExpansionPlansScreenState,
    migrated10.TerritoryExpansionManagerForecastScreenState,
    migrated11.TerritoryExpansionManagerMarketResearchScreenState,
    migrated12.TerritoryExpansionManagerOpenTerritoriesScreenState,
    migrated13.TerritoryExpansionManagerReportsScreenState,
    migrated14.TerritoryExpansionManagerSiteSelectionScreenState,
    migrated15.TerritoryExpansionManagerTerritoryMapScreenState,
    migrated16.PartnershipManagerActiveDealsScreenState,
    migrated17.PartnershipManagerOutreachScreenState,
    migrated18.PartnershipManagerPartnersScreenState,
    migrated19.PartnershipManagerProposalsScreenState,
    migrated20.PartnershipManagerRenewalsScreenState,
    migrated21.PartnershipManagerReportsScreenState,
    migrated22.RegionalManagerOntarioDashboardScreenState,
    ];
    expect(migratedTypes, hasLength(23));
  });
}
