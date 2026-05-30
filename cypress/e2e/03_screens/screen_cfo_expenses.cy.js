// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - cfo_expenses", () => {
  it("opens and verifies screen cfo_expenses", () => {
    cy.loginAsRole("cfo");

  cy.task("log", "⏳ PROGRESS: - Navigating to /executive/cfo-expenses (CfoExpensesScreen)...");
  cy.visitWithSemantics("/executive/cfo-expenses");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for CfoExpensesScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("cfoexpenses-screen").should("be.visible");
  cy.getCy("cfoexpenses-title").should("be.visible");
  cy.getCy("cfoexpenses-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for CfoExpensesScreen...");
  cy.waitAndSee();
  cy.screenshot("cfo_expenses");
  
  cy.task("log", "✅ PROGRESS: - Verified CfoExpensesScreen successfully!\n");

  });
});
