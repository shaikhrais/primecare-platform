// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - local_marketing_manager_analytics", () => {
  it("opens and verifies screen local_marketing_manager_analytics", () => {
    cy.loginAsRole("local_marketing");

  cy.task("log", "⏳ PROGRESS: - Navigating to /management/local-marketing-manager-analytics (LocalMarketingManagerAnalyticsScreen)...");
  cy.visitWithSemantics("/management/local-marketing-manager-analytics");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for LocalMarketingManagerAnalyticsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("localmarketingmanageranalytics-screen").should("be.visible");
  cy.getCy("localmarketingmanageranalytics-title").should("be.visible");
  cy.getCy("localmarketingmanageranalytics-content").should("be.visible");
  cy.getCy("localmarketing-kpi-overview").should("be.visible");
  cy.getCy("localmarketing-refresh-data").should("be.visible");
  cy.getCy("localmarketing-export-metrics").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for LocalMarketingManagerAnalyticsScreen...");
  cy.waitAndSee();
  cy.screenshot("local_marketing_manager_analytics");
  
  cy.task("log", "✅ PROGRESS: - Verified LocalMarketingManagerAnalyticsScreen successfully!\n");

  });
});
