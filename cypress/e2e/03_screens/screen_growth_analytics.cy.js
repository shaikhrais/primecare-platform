// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - growth_analytics", () => {
  it("opens and verifies screen growth_analytics", () => {
    cy.loginAsRole("bus_dev");

  cy.task("log", "⏳ PROGRESS: - Navigating to /management/growth-analytics (GrowthAnalyticsScreen)...");
  cy.visitWithSemantics("/management/growth-analytics");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for GrowthAnalyticsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("growthanalytics-screen").should("be.visible");
  cy.getCy("growthanalytics-title").should("be.visible");
  cy.getCy("growthanalytics-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for GrowthAnalyticsScreen...");
  cy.waitAndSee();
  cy.screenshot("growth_analytics");
  
  cy.task("log", "✅ PROGRESS: - Verified GrowthAnalyticsScreen successfully!\n");

  });
});
