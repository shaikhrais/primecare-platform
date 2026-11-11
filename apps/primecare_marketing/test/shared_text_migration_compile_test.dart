// Compile smoke coverage for constructor-only shared text migration.
// This does not claim individual screen runtime acceptance.
import 'package:flutter_test/flutter_test.dart';
import 'package:primecare_marketing/features/generated_screens/community_outreach_contacts_screen.dart' as migrated0;
import 'package:primecare_marketing/features/generated_screens/community_outreach_events_screen.dart' as migrated1;
import 'package:primecare_marketing/features/generated_screens/community_outreach_follow_ups_screen.dart' as migrated2;
import 'package:primecare_marketing/features/generated_screens/community_outreach_partnerships_screen.dart' as migrated3;
import 'package:primecare_marketing/features/generated_screens/community_outreach_programs_screen.dart' as migrated4;
import 'package:primecare_marketing/features/generated_screens/community_outreach_reports_screen.dart' as migrated5;
import 'package:primecare_marketing/features/generated_screens/community_outreach_volunteers_screen.dart' as migrated6;
import 'package:primecare_marketing/features/generated_screens/head_of_marketing_brand_assets_screen.dart' as migrated7;
import 'package:primecare_marketing/features/generated_screens/head_of_marketing_campaigns_screen.dart' as migrated8;
import 'package:primecare_marketing/features/generated_screens/head_of_marketing_content_approval_screen.dart' as migrated9;
import 'package:primecare_marketing/features/generated_screens/head_of_marketing_funnel_analytics_screen.dart' as migrated10;
import 'package:primecare_marketing/features/generated_screens/head_of_marketing_leads_screen.dart' as migrated11;
import 'package:primecare_marketing/features/generated_screens/head_of_marketing_performance_reports_screen.dart' as migrated12;
import 'package:primecare_marketing/features/generated_screens/head_of_marketing_regional_campaigns_screen.dart' as migrated13;
import 'package:primecare_marketing/features/generated_screens/local_marketing_manager_assets_screen.dart' as migrated14;
import 'package:primecare_marketing/features/generated_screens/local_marketing_manager_budget_screen.dart' as migrated15;
import 'package:primecare_marketing/features/generated_screens/local_marketing_manager_campaigns_screen.dart' as migrated16;
import 'package:primecare_marketing/features/generated_screens/local_marketing_manager_content_calendar_screen.dart' as migrated17;
import 'package:primecare_marketing/features/generated_screens/local_marketing_manager_events_screen.dart' as migrated18;
import 'package:primecare_marketing/features/generated_screens/local_marketing_manager_leads_screen.dart' as migrated19;
import 'package:primecare_marketing/features/generated_screens/local_marketing_manager_reports_screen.dart' as migrated20;
import 'package:primecare_marketing/features/generated_screens/territory_sales_manager_area_performance_screen.dart' as migrated21;
import 'package:primecare_marketing/features/generated_screens/territory_sales_manager_competitors_screen.dart' as migrated22;
import 'package:primecare_marketing/features/generated_screens/territory_sales_manager_conversions_screen.dart' as migrated23;
import 'package:primecare_marketing/features/generated_screens/territory_sales_manager_field_activity_screen.dart' as migrated24;
import 'package:primecare_marketing/features/generated_screens/territory_sales_manager_leads_screen.dart' as migrated25;
import 'package:primecare_marketing/features/generated_screens/territory_sales_manager_pipeline_screen.dart' as migrated26;
import 'package:primecare_marketing/features/generated_screens/territory_sales_manager_reports_screen.dart' as migrated27;

void main() {
  test('migrated consumer libraries compile', () {
    const migratedTypes = <Type>[
    migrated0.CommunityOutreachContactsScreenState,
    migrated1.CommunityOutreachEventsScreenState,
    migrated2.CommunityOutreachFollowUpsScreenState,
    migrated3.CommunityOutreachPartnershipsScreenState,
    migrated4.CommunityOutreachProgramsScreenState,
    migrated5.CommunityOutreachReportsScreenState,
    migrated6.CommunityOutreachVolunteersScreenState,
    migrated7.HeadOfMarketingBrandAssetsScreenState,
    migrated8.HeadOfMarketingCampaignsScreenState,
    migrated9.HeadOfMarketingContentApprovalScreenState,
    migrated10.HeadOfMarketingFunnelAnalyticsScreenState,
    migrated11.HeadOfMarketingLeadsScreenState,
    migrated12.HeadOfMarketingPerformanceReportsScreenState,
    migrated13.HeadOfMarketingRegionalCampaignsScreenState,
    migrated14.LocalMarketingManagerAssetsScreenState,
    migrated15.LocalMarketingManagerBudgetScreenState,
    migrated16.LocalMarketingManagerCampaignsScreenState,
    migrated17.LocalMarketingManagerContentCalendarScreenState,
    migrated18.LocalMarketingManagerEventsScreenState,
    migrated19.LocalMarketingManagerLeadsScreenState,
    migrated20.LocalMarketingManagerReportsScreenState,
    migrated21.TerritorySalesManagerAreaPerformanceScreenState,
    migrated22.TerritorySalesManagerCompetitorsScreenState,
    migrated23.TerritorySalesManagerConversionsScreenState,
    migrated24.TerritorySalesManagerFieldActivityScreenState,
    migrated25.TerritorySalesManagerLeadsScreenState,
    migrated26.TerritorySalesManagerPipelineScreenState,
    migrated27.TerritorySalesManagerReportsScreenState,
    ];
    expect(migratedTypes, hasLength(28));
  });
}
