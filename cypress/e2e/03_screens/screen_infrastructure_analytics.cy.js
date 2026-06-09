// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - infrastructure_analytics", () => {
  it("opens and verifies screen infrastructure_analytics", () => {
    cy.loginAsRole("infrastructure");

  cy.task("log", "⏳ PROGRESS: - Navigating to /common/infrastructure-analytics (InfrastructureAnalyticsScreen)...");
  cy.visitWithSemantics("/common/infrastructure-analytics");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for InfrastructureAnalyticsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("infrastructureanalytics-screen").should("be.visible");
  cy.getCy("infrastructureanalytics-title").should("be.visible");
  cy.getCy("infrastructureanalytics-content").should("be.visible");
  cy.getCy("infrastructure-dashboard-health").should("be.visible");
  cy.getCy("infrastructure-dashboard-compliance").should("be.visible");
  cy.getCy("infrastructure-dashboard-performance").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for InfrastructureAnalyticsScreen...");
  cy.waitAndSee();
  cy.screenshot("infrastructure_analytics");
  
  cy.task("log", "✅ PROGRESS: - Verified InfrastructureAnalyticsScreen successfully!\n");

  });
});
