// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Role All Screens - marketing", () => {
  it("tests all screens for role marketing", () => {
    cy.loginAsRole("marketing");


  cy.task("log", "⏳ PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/12 | 8%] - Navigating to /offices/corporate/roles/head_of_marketing/dashboard (HeadOfMarketingDashboardScreen)...");
  cy.visitWithSemantics("/offices/corporate/roles/head_of_marketing/dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/12 | 8%] - Checking shell & content for HeadOfMarketingDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("headofmarketingdashboard-screen").should("be.visible");
  cy.getCy("headofmarketingdashboard-title").should("be.visible");
  cy.getCy("headofmarketingdashboard-content").should("be.visible");
  cy.getCy("marketing-dashboard-campaigns").should("be.visible");
  cy.getCy("marketing-dashboard-analytics").should("be.visible");
  cy.getCy("marketing-dashboard-budget").should("be.visible");

  cy.task("log", "📸 PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/12 | 8%] - Saving screenshot for HeadOfMarketingDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("head_of_marketing_dashboard");
  
  cy.task("log", "✅ PROGRESS: ⬜⬜⬜⬜⬜⬜⬜⬜⬜⬜ [1/12 | 8%] - Verified HeadOfMarketingDashboardScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [2/12 | 16%] - Navigating to /offices/marketing/roles/local_marketing_manager/dashboard (LocalMarketingManagerDashboardScreen)...");
  cy.visitWithSemantics("/offices/marketing/roles/local_marketing_manager/dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [2/12 | 16%] - Checking shell & content for LocalMarketingManagerDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("localmarketingmanagerdashboard-screen").should("be.visible");
  cy.getCy("localmarketingmanagerdashboard-title").should("be.visible");
  cy.getCy("localmarketingmanagerdashboard-content").should("be.visible");
  cy.getCy("localmarketing-dashboard-campaigns").should("be.visible");
  cy.getCy("localmarketing-dashboard-socialmedia").should("be.visible");
  cy.getCy("localmarketing-dashboard-feedback").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [2/12 | 16%] - Saving screenshot for LocalMarketingManagerDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("local_marketing_manager_dashboard");
  
  cy.task("log", "✅ PROGRESS: 🟩⬜⬜⬜⬜⬜⬜⬜⬜⬜ [2/12 | 16%] - Verified LocalMarketingManagerDashboardScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [3/12 | 25%] - Navigating to /management/head-of-marketing-analytics (HeadOfMarketingAnalyticsScreen)...");
  cy.visitWithSemantics("/management/head-of-marketing-analytics");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [3/12 | 25%] - Checking shell & content for HeadOfMarketingAnalyticsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("headofmarketinganalytics-screen").should("be.visible");
  cy.getCy("headofmarketinganalytics-title").should("be.visible");
  cy.getCy("headofmarketinganalytics-content").should("be.visible");
  cy.getCy("marketing-dashboard-kpi").should("be.visible");
  cy.getCy("marketing-dashboard-realtime-analytics").should("be.visible");
  cy.getCy("marketing-dashboard-social-media").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [3/12 | 25%] - Saving screenshot for HeadOfMarketingAnalyticsScreen...");
  cy.waitAndSee();
  cy.screenshot("head_of_marketing_analytics");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [3/12 | 25%] - Verified HeadOfMarketingAnalyticsScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [4/12 | 33%] - Navigating to /management/head-of-marketing-compliance (HeadOfMarketingComplianceScreen)...");
  cy.visitWithSemantics("/management/head-of-marketing-compliance");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [4/12 | 33%] - Checking shell & content for HeadOfMarketingComplianceScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("headofmarketingcompliance-screen").should("be.visible");
  cy.getCy("headofmarketingcompliance-title").should("be.visible");
  cy.getCy("headofmarketingcompliance-content").should("be.visible");
  cy.getCy("marketing-dashboard-campaigns").should("be.visible");
  cy.getCy("marketing-dashboard-kpis").should("be.visible");
  cy.getCy("marketing-dashboard-analytics").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [4/12 | 33%] - Saving screenshot for HeadOfMarketingComplianceScreen...");
  cy.waitAndSee();
  cy.screenshot("head_of_marketing_compliance");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩⬜⬜⬜⬜⬜⬜⬜ [4/12 | 33%] - Verified HeadOfMarketingComplianceScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [5/12 | 41%] - Navigating to /management/head-of-marketing-workflow (HeadOfMarketingWorkflowScreen)...");
  cy.visitWithSemantics("/management/head-of-marketing-workflow");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [5/12 | 41%] - Checking shell & content for HeadOfMarketingWorkflowScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("headofmarketingworkflow-screen").should("be.visible");
  cy.getCy("headofmarketingworkflow-title").should("be.visible");
  cy.getCy("headofmarketingworkflow-content").should("be.visible");
  cy.getCy("marketing-dashboard-btn-view-campaigns").should("be.visible");
  cy.getCy("marketing-dashboard-btn-analyze-kpis").should("be.visible");
  cy.getCy("marketing-dashboard-btn-check-budget").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [5/12 | 41%] - Saving screenshot for HeadOfMarketingWorkflowScreen...");
  cy.waitAndSee();
  cy.screenshot("head_of_marketing_workflow");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩⬜⬜⬜⬜⬜⬜ [5/12 | 41%] - Verified HeadOfMarketingWorkflowScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [6/12 | 50%] - Navigating to /management/local-marketing-manager-analytics (LocalMarketingManagerAnalyticsScreen)...");
  cy.visitWithSemantics("/management/local-marketing-manager-analytics");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [6/12 | 50%] - Checking shell & content for LocalMarketingManagerAnalyticsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("localmarketingmanageranalytics-screen").should("be.visible");
  cy.getCy("localmarketingmanageranalytics-title").should("be.visible");
  cy.getCy("localmarketingmanageranalytics-content").should("be.visible");
  cy.getCy("localmarketing-kpi-overview").should("be.visible");
  cy.getCy("localmarketing-refresh-data").should("be.visible");
  cy.getCy("localmarketing-export-metrics").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [6/12 | 50%] - Saving screenshot for LocalMarketingManagerAnalyticsScreen...");
  cy.waitAndSee();
  cy.screenshot("local_marketing_manager_analytics");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [6/12 | 50%] - Verified LocalMarketingManagerAnalyticsScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [7/12 | 58%] - Navigating to /management/local-marketing-manager-compliance (LocalMarketingManagerComplianceScreen)...");
  cy.visitWithSemantics("/management/local-marketing-manager-compliance");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [7/12 | 58%] - Checking shell & content for LocalMarketingManagerComplianceScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("localmarketingmanagercompliance-screen").should("be.visible");
  cy.getCy("localmarketingmanagercompliance-title").should("be.visible");
  cy.getCy("localmarketingmanagercompliance-content").should("be.visible");
  cy.getCy("localmarketing-btn-generate-report").should("be.visible");
  cy.getCy("localmarketing-btn-view-campaign").should("be.visible");
  cy.getCy("localmarketing-btn-track-budget").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [7/12 | 58%] - Saving screenshot for LocalMarketingManagerComplianceScreen...");
  cy.waitAndSee();
  cy.screenshot("local_marketing_manager_compliance");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [7/12 | 58%] - Verified LocalMarketingManagerComplianceScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [8/12 | 66%] - Navigating to /management/local-marketing-manager-workflow (LocalMarketingManagerWorkflowScreen)...");
  cy.visitWithSemantics("/management/local-marketing-manager-workflow");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [8/12 | 66%] - Checking shell & content for LocalMarketingManagerWorkflowScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("localmarketingmanagerworkflow-screen").should("be.visible");
  cy.getCy("localmarketingmanagerworkflow-title").should("be.visible");
  cy.getCy("localmarketingmanagerworkflow-content").should("be.visible");
  cy.getCy("localmarketing-btn-addcampaign").should("be.visible");
  cy.getCy("localmarketing-btn-viewreports").should("be.visible");
  cy.getCy("localmarketing-btn-adjustbudget").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [8/12 | 66%] - Saving screenshot for LocalMarketingManagerWorkflowScreen...");
  cy.waitAndSee();
  cy.screenshot("local_marketing_manager_workflow");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩⬜⬜⬜⬜ [8/12 | 66%] - Verified LocalMarketingManagerWorkflowScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [9/12 | 75%] - Navigating to /management/campaign-dashboard (CampaignDashboardScreen)...");
  cy.visitWithSemantics("/management/campaign-dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [9/12 | 75%] - Checking shell & content for CampaignDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("campaigndashboard-screen").should("be.visible");
  cy.getCy("campaigndashboard-title").should("be.visible");
  cy.getCy("campaigndashboard-content").should("be.visible");
  cy.getCy("campaign-dashboard-refresh").should("be.visible");
  cy.getCy("campaign-dashboard-view-report").should("be.visible");
  cy.getCy("campaign-dashboard-export-metrics").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [9/12 | 75%] - Saving screenshot for CampaignDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("campaign_dashboard");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [9/12 | 75%] - Verified CampaignDashboardScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [10/12 | 83%] - Navigating to /management/lead-analytics (LeadAnalyticsScreen)...");
  cy.visitWithSemantics("/management/lead-analytics");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [10/12 | 83%] - Checking shell & content for LeadAnalyticsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("leadanalytics-screen").should("be.visible");
  cy.getCy("leadanalytics-title").should("be.visible");
  cy.getCy("leadanalytics-content").should("be.visible");
  cy.getCy("leadanalytics-btn-refresh").should("be.visible");
  cy.getCy("leadanalytics-btn-export").should("be.visible");
  cy.getCy("leadanalytics-btn-viewdetails").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [10/12 | 83%] - Saving screenshot for LeadAnalyticsScreen...");
  cy.waitAndSee();
  cy.screenshot("lead_analytics");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩⬜⬜ [10/12 | 83%] - Verified LeadAnalyticsScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [11/12 | 91%] - Navigating to /management/social-media (SocialMediaScreen)...");
  cy.visitWithSemantics("/management/social-media");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [11/12 | 91%] - Checking shell & content for SocialMediaScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("socialmedia-screen").should("be.visible");
  cy.getCy("socialmedia-title").should("be.visible");
  cy.getCy("socialmedia-content").should("be.visible");
  cy.getCy("marketing-dashboard-btn-view-campaign").should("be.visible");
  cy.getCy("marketing-dashboard-btn-export-reports").should("be.visible");
  cy.getCy("marketing-dashboard-btn-analyze-trends").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [11/12 | 91%] - Saving screenshot for SocialMediaScreen...");
  cy.waitAndSee();
  cy.screenshot("social_media");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩⬜ [11/12 | 91%] - Verified SocialMediaScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [12/12 | 100%] - Navigating to /management/brand-management (BrandManagementScreen)...");
  cy.visitWithSemantics("/management/brand-management");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [12/12 | 100%] - Checking shell & content for BrandManagementScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("brandmanagement-screen").should("be.visible");
  cy.getCy("brandmanagement-title").should("be.visible");
  cy.getCy("brandmanagement-content").should("be.visible");
  cy.getCy("marketing-dashboard-campaign-overview").should("be.visible");
  cy.getCy("marketing-dashboard-kpi-chart").should("be.visible");
  cy.getCy("marketing-dashboard-real-time-analytics").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [12/12 | 100%] - Saving screenshot for BrandManagementScreen...");
  cy.waitAndSee();
  cy.screenshot("brand_management");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [12/12 | 100%] - Verified BrandManagementScreen successfully!\n");

  });
});
