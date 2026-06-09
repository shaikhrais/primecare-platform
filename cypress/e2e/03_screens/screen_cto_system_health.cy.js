// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - cto_system_health", () => {
  it("opens and verifies screen cto_system_health", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/corporate/roles/cto/system-health (Cto System Health)...");
  cy.visitWithSemantics("/offices/corporate/roles/cto/system-health");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Cto System Health...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("ctosystemhealth-screen").should("be.visible");
  cy.getCy("ctosystemhealth-title").should("be.visible");
  cy.getCy("ctosystemhealth-content").should("be.visible");
  cy.getCy("systemhealth-metric-display").should("be.visible");
  cy.getCy("systemhealth-alert-notification").should("be.visible");
  cy.getCy("systemhealth-performance-graph").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Cto System Health...");
  cy.waitAndSee();
  cy.screenshot("cto_system_health");
  
  cy.task("log", "✅ PROGRESS: - Verified Cto System Health successfully!\n");

  });
});
