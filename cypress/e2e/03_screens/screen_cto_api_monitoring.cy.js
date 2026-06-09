// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - cto_api_monitoring", () => {
  it("opens and verifies screen cto_api_monitoring", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/corporate/roles/cto/api-monitoring (Cto Api Monitoring)...");
  cy.visitWithSemantics("/offices/corporate/roles/cto/api-monitoring");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Cto Api Monitoring...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("ctoapimonitoring-screen").should("be.visible");
  cy.getCy("ctoapimonitoring-title").should("be.visible");
  cy.getCy("ctoapimonitoring-content").should("be.visible");
  cy.getCy("api-monitoring-btn-set-alert").should("be.visible");
  cy.getCy("api-monitoring-btn-generate-report").should("be.visible");
  cy.getCy("api-monitoring-btn-collaborate").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Cto Api Monitoring...");
  cy.waitAndSee();
  cy.screenshot("cto_api_monitoring");
  
  cy.task("log", "✅ PROGRESS: - Verified Cto Api Monitoring successfully!\n");

  });
});
