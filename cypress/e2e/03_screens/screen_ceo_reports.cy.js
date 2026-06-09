// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - ceo_reports", () => {
  it("opens and verifies screen ceo_reports", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/corporate/roles/ceo/reports (Ceo Reports)...");
  cy.visitWithSemantics("/offices/corporate/roles/ceo/reports");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Ceo Reports...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("ceoreports-screen").should("be.visible");
  cy.getCy("ceoreports-title").should("be.visible");
  cy.getCy("ceoreports-content").should("be.visible");
  cy.getCy("ceo-reports-btn-refresh").should("be.visible");
  cy.getCy("ceo-reports-btn-report-issue").should("be.visible");
  cy.getCy("ceo-reports-btn-request-feature").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Ceo Reports...");
  cy.waitAndSee();
  cy.screenshot("ceo_reports");
  
  cy.task("log", "✅ PROGRESS: - Verified Ceo Reports successfully!\n");

  });
});
