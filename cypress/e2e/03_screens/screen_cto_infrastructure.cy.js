// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - cto_infrastructure", () => {
  it("opens and verifies screen cto_infrastructure", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/corporate/roles/cto/infrastructure (Cto Infrastructure)...");
  cy.visitWithSemantics("/offices/corporate/roles/cto/infrastructure");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Cto Infrastructure...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("ctoinfrastructure-screen").should("be.visible");
  cy.getCy("ctoinfrastructure-title").should("be.visible");
  cy.getCy("ctoinfrastructure-content").should("be.visible");
  cy.getCy("cto-infrastructure-status").should("be.visible");
  cy.getCy("cto-error-log-alert").should("be.visible");
  cy.getCy("cto-performance-metrics").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Cto Infrastructure...");
  cy.waitAndSee();
  cy.screenshot("cto_infrastructure");
  
  cy.task("log", "✅ PROGRESS: - Verified Cto Infrastructure successfully!\n");

  });
});
