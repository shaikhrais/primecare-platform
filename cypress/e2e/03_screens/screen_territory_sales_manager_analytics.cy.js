// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - territory_sales_manager_analytics", () => {
  it("opens and verifies screen territory_sales_manager_analytics", () => {
    cy.loginAsRole("territory_sales");

  cy.task("log", "⏳ PROGRESS: - Navigating to /management/territory-sales-manager-analytics (TerritorySalesManagerAnalyticsScreen)...");
  cy.visitWithSemantics("/management/territory-sales-manager-analytics");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for TerritorySalesManagerAnalyticsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("territorysalesmanageranalytics-screen").should("be.visible");
  cy.getCy("territorysalesmanageranalytics-title").should("be.visible");
  cy.getCy("territorysalesmanageranalytics-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for TerritorySalesManagerAnalyticsScreen...");
  cy.waitAndSee();
  cy.screenshot("territory_sales_manager_analytics");
  
  cy.task("log", "✅ PROGRESS: - Verified TerritorySalesManagerAnalyticsScreen successfully!\n");

  });
});
