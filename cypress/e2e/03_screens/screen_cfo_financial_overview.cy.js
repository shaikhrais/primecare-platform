// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - cfo_financial_overview", () => {
  it("opens and verifies screen cfo_financial_overview", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/corporate/roles/cfo/financial-overview (Cfo Financial Overview)...");
  cy.visitWithSemantics("/offices/corporate/roles/cfo/financial-overview");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Cfo Financial Overview...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("cfofinancialoverview-screen").should("be.visible");
  cy.getCy("cfofinancialoverview-title").should("be.visible");
  cy.getCy("cfofinancialoverview-content").should("be.visible");
  cy.getCy("financial-overview-refresh").should("be.visible");
  cy.getCy("financial-overview-customize").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Cfo Financial Overview...");
  cy.waitAndSee();
  cy.screenshot("cfo_financial_overview");
  
  cy.task("log", "✅ PROGRESS: - Verified Cfo Financial Overview successfully!\n");

  });
});
