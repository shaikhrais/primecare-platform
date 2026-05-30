// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - regional_manager_usa_analytics", () => {
  it("opens and verifies screen regional_manager_usa_analytics", () => {
    cy.loginAsRole("regional_manager_usa");

  cy.task("log", "⏳ PROGRESS: - Navigating to /management/regional-manager-usa-analytics (RegionalManagerUsaAnalyticsScreen)...");
  cy.visitWithSemantics("/management/regional-manager-usa-analytics");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for RegionalManagerUsaAnalyticsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("regionalmanagerusaanalytics-screen").should("be.visible");
  cy.getCy("regionalmanagerusaanalytics-title").should("be.visible");
  cy.getCy("regionalmanagerusaanalytics-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for RegionalManagerUsaAnalyticsScreen...");
  cy.waitAndSee();
  cy.screenshot("regional_manager_usa_analytics");
  
  cy.task("log", "✅ PROGRESS: - Verified RegionalManagerUsaAnalyticsScreen successfully!\n");

  });
});
