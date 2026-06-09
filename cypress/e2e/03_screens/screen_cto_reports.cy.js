// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - cto_reports", () => {
  it("opens and verifies screen cto_reports", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/corporate/roles/cto/reports (Cto Reports)...");
  cy.visitWithSemantics("/offices/corporate/roles/cto/reports");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Cto Reports...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("ctoreports-screen").should("be.visible");
  cy.getCy("ctoreports-title").should("be.visible");
  cy.getCy("ctoreports-content").should("be.visible");
  cy.getCy("cto_reports-btn-submit_feedback").should("be.visible");
  cy.getCy("cto_reports-btn-refresh_data").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Cto Reports...");
  cy.waitAndSee();
  cy.screenshot("cto_reports");
  
  cy.task("log", "✅ PROGRESS: - Verified Cto Reports successfully!\n");

  });
});
