// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - territory_expansion_manager_analytics", () => {
  it("opens and verifies screen territory_expansion_manager_analytics", () => {
    cy.loginAsRole("territory_expansion");

  cy.task("log", "⏳ PROGRESS: - Navigating to /management/territory-expansion-manager-analytics (TerritoryExpansionManagerAnalyticsScreen)...");
  cy.visitWithSemantics("/management/territory-expansion-manager-analytics");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for TerritoryExpansionManagerAnalyticsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("territoryexpansionmanageranalytics-screen").should("be.visible");
  cy.getCy("territoryexpansionmanageranalytics-title").should("be.visible");
  cy.getCy("territoryexpansionmanageranalytics-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for TerritoryExpansionManagerAnalyticsScreen...");
  cy.waitAndSee();
  cy.screenshot("territory_expansion_manager_analytics");
  
  cy.task("log", "✅ PROGRESS: - Verified TerritoryExpansionManagerAnalyticsScreen successfully!\n");

  });
});
