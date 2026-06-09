// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - audits", () => {
  it("opens and verifies screen audits", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/corporate/roles/compliance_manager/audits (Audits)...");
  cy.visitWithSemantics("/offices/corporate/roles/compliance_manager/audits");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Audits...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("audits-screen").should("be.visible");
  cy.getCy("audits-title").should("be.visible");
  cy.getCy("audits-content").should("be.visible");
  cy.getCy("audit-status-overview").should("be.visible");
  cy.getCy("audit-kpi-chart").should("be.visible");
  cy.getCy("red-flag-alert").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Audits...");
  cy.waitAndSee();
  cy.screenshot("audits");
  
  cy.task("log", "✅ PROGRESS: - Verified Audits successfully!\n");

  });
});
