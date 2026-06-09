// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Role All Screens - local_marketing", () => {
  it("tests all screens for role local_marketing", () => {
    cy.loginAsRole("local_marketing");


  cy.task("log", "⏳ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [1/4 | 25%] - Navigating to /offices/marketing/roles/local_marketing_manager/dashboard (LocalMarketingManagerDashboardScreen)...");
  cy.visitWithSemantics("/offices/marketing/roles/local_marketing_manager/dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [1/4 | 25%] - Checking shell & content for LocalMarketingManagerDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("localmarketingmanagerdashboard-screen").should("be.visible");
  cy.getCy("localmarketingmanagerdashboard-title").should("be.visible");
  cy.getCy("localmarketingmanagerdashboard-content").should("be.visible");
  cy.getCy("localmarketing-dashboard-campaigns").should("be.visible");
  cy.getCy("localmarketing-dashboard-socialmedia").should("be.visible");
  cy.getCy("localmarketing-dashboard-feedback").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [1/4 | 25%] - Saving screenshot for LocalMarketingManagerDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("local_marketing_manager_dashboard");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩⬜⬜⬜⬜⬜⬜⬜⬜ [1/4 | 25%] - Verified LocalMarketingManagerDashboardScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [2/4 | 50%] - Navigating to /management/local-marketing-manager-analytics (LocalMarketingManagerAnalyticsScreen)...");
  cy.visitWithSemantics("/management/local-marketing-manager-analytics");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [2/4 | 50%] - Checking shell & content for LocalMarketingManagerAnalyticsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("localmarketingmanageranalytics-screen").should("be.visible");
  cy.getCy("localmarketingmanageranalytics-title").should("be.visible");
  cy.getCy("localmarketingmanageranalytics-content").should("be.visible");
  cy.getCy("localmarketing-kpi-overview").should("be.visible");
  cy.getCy("localmarketing-refresh-data").should("be.visible");
  cy.getCy("localmarketing-export-metrics").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [2/4 | 50%] - Saving screenshot for LocalMarketingManagerAnalyticsScreen...");
  cy.waitAndSee();
  cy.screenshot("local_marketing_manager_analytics");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩⬜⬜⬜⬜⬜ [2/4 | 50%] - Verified LocalMarketingManagerAnalyticsScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [3/4 | 75%] - Navigating to /management/local-marketing-manager-compliance (LocalMarketingManagerComplianceScreen)...");
  cy.visitWithSemantics("/management/local-marketing-manager-compliance");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [3/4 | 75%] - Checking shell & content for LocalMarketingManagerComplianceScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("localmarketingmanagercompliance-screen").should("be.visible");
  cy.getCy("localmarketingmanagercompliance-title").should("be.visible");
  cy.getCy("localmarketingmanagercompliance-content").should("be.visible");
  cy.getCy("localmarketing-btn-generate-report").should("be.visible");
  cy.getCy("localmarketing-btn-view-campaign").should("be.visible");
  cy.getCy("localmarketing-btn-track-budget").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [3/4 | 75%] - Saving screenshot for LocalMarketingManagerComplianceScreen...");
  cy.waitAndSee();
  cy.screenshot("local_marketing_manager_compliance");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩⬜⬜⬜ [3/4 | 75%] - Verified LocalMarketingManagerComplianceScreen successfully!\n");

  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [4/4 | 100%] - Navigating to /management/local-marketing-manager-workflow (LocalMarketingManagerWorkflowScreen)...");
  cy.visitWithSemantics("/management/local-marketing-manager-workflow");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [4/4 | 100%] - Checking shell & content for LocalMarketingManagerWorkflowScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("localmarketingmanagerworkflow-screen").should("be.visible");
  cy.getCy("localmarketingmanagerworkflow-title").should("be.visible");
  cy.getCy("localmarketingmanagerworkflow-content").should("be.visible");
  cy.getCy("localmarketing-btn-addcampaign").should("be.visible");
  cy.getCy("localmarketing-btn-viewreports").should("be.visible");
  cy.getCy("localmarketing-btn-adjustbudget").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [4/4 | 100%] - Saving screenshot for LocalMarketingManagerWorkflowScreen...");
  cy.waitAndSee();
  cy.screenshot("local_marketing_manager_workflow");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [4/4 | 100%] - Verified LocalMarketingManagerWorkflowScreen successfully!\n");

  });
});
