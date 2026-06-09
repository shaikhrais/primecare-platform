// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - cfo_reports", () => {
  it("opens and verifies screen cfo_reports", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/corporate/roles/cfo/reports (Cfo Reports)...");
  cy.visitWithSemantics("/offices/corporate/roles/cfo/reports");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Cfo Reports...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("cforeports-screen").should("be.visible");
  cy.getCy("cforeports-title").should("be.visible");
  cy.getCy("cforeports-content").should("be.visible");
  cy.getCy("cfo-reports-btn-refresh").should("be.visible");
  cy.getCy("cfo-reports-btn-view-detail").should("be.visible");
  cy.getCy("cfo-reports-btn-submit-feedback").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Cfo Reports...");
  cy.waitAndSee();
  cy.screenshot("cfo_reports");
  
  cy.task("log", "✅ PROGRESS: - Verified Cfo Reports successfully!\n");

  });
});
