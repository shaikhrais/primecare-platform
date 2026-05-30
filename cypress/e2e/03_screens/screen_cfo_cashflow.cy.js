// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - cfo_cashflow", () => {
  it("opens and verifies screen cfo_cashflow", () => {
    cy.loginAsRole("cfo");

  cy.task("log", "⏳ PROGRESS: - Navigating to /executive/cfo-cashflow (CfoCashflowScreen)...");
  cy.visitWithSemantics("/executive/cfo-cashflow");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for CfoCashflowScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("cfocashflow-screen").should("be.visible");
  cy.getCy("cfocashflow-title").should("be.visible");
  cy.getCy("cfocashflow-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for CfoCashflowScreen...");
  cy.waitAndSee();
  cy.screenshot("cfo_cashflow");
  
  cy.task("log", "✅ PROGRESS: - Verified CfoCashflowScreen successfully!\n");

  });
});
