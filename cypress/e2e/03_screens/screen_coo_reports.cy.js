// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - coo_reports", () => {
  it("opens and verifies screen coo_reports", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/corporate/roles/coo/reports (Coo Reports)...");
  cy.visitWithSemantics("/offices/corporate/roles/coo/reports");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Coo Reports...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("cooreports-screen").should("be.visible");
  cy.getCy("cooreports-title").should("be.visible");
  cy.getCy("cooreports-content").should("be.visible");
  cy.getCy("coo-reports-status").should("be.visible");
  cy.getCy("coo-reports-analyze").should("be.visible");
  cy.getCy("coo-reports-trends").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Coo Reports...");
  cy.waitAndSee();
  cy.screenshot("coo_reports");
  
  cy.task("log", "✅ PROGRESS: - Verified Coo Reports successfully!\n");

  });
});
