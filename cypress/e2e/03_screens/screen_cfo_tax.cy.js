// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - cfo_tax", () => {
  it("opens and verifies screen cfo_tax", () => {
    cy.loginAsRole("cfo");

  cy.task("log", "⏳ PROGRESS: - Navigating to /executive/cfo-tax (CfoTaxScreen)...");
  cy.visitWithSemantics("/executive/cfo-tax");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for CfoTaxScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("cfotax-screen").should("be.visible");
  cy.getCy("cfotax-title").should("be.visible");
  cy.getCy("cfotax-content").should("be.visible");
  cy.getCy("cfo-dashboard-kpi-overview").should("be.visible");
  cy.getCy("cfo-dashboard-revenue-expense-trend").should("be.visible");
  cy.getCy("cfo-dashboard-cash-flow-projection").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for CfoTaxScreen...");
  cy.waitAndSee();
  cy.screenshot("cfo_tax");
  
  cy.task("log", "✅ PROGRESS: - Verified CfoTaxScreen successfully!\n");

  });
});
