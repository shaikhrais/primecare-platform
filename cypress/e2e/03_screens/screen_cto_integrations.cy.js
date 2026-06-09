// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - cto_integrations", () => {
  it("opens and verifies screen cto_integrations", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/corporate/roles/cto/integrations (Cto Integrations)...");
  cy.visitWithSemantics("/offices/corporate/roles/cto/integrations");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Cto Integrations...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("ctointegrations-screen").should("be.visible");
  cy.getCy("ctointegrations-title").should("be.visible");
  cy.getCy("ctointegrations-content").should("be.visible");
  cy.getCy("integration-status-indicator").should("be.visible");
  cy.getCy("error-log-summary").should("be.visible");
  cy.getCy("data-sync-metric").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Cto Integrations...");
  cy.waitAndSee();
  cy.screenshot("cto_integrations");
  
  cy.task("log", "✅ PROGRESS: - Verified Cto Integrations successfully!\n");

  });
});
