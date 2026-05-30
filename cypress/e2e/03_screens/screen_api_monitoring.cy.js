// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - api_monitoring", () => {
  it("opens and verifies screen api_monitoring", () => {
    cy.loginAsRole("cto");

  cy.task("log", "⏳ PROGRESS: - Navigating to /executive/api-monitoring (ApiMonitoringScreen)...");
  cy.visitWithSemantics("/executive/api-monitoring");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for ApiMonitoringScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("apimonitoring-screen").should("be.visible");
  cy.getCy("apimonitoring-title").should("be.visible");
  cy.getCy("apimonitoring-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for ApiMonitoringScreen...");
  cy.waitAndSee();
  cy.screenshot("api_monitoring");
  
  cy.task("log", "✅ PROGRESS: - Verified ApiMonitoringScreen successfully!\n");

  });
});
