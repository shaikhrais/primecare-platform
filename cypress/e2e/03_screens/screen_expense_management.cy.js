// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - expense_management", () => {
  it("opens and verifies screen expense_management", () => {
    cy.loginAsRole("cfo");

  cy.task("log", "⏳ PROGRESS: - Navigating to /executive/expense-management (ExpenseManagementScreen)...");
  cy.visitWithSemantics("/executive/expense-management");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for ExpenseManagementScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("expensemanagement-screen").should("be.visible");
  cy.getCy("expensemanagement-title").should("be.visible");
  cy.getCy("expensemanagement-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for ExpenseManagementScreen...");
  cy.waitAndSee();
  cy.screenshot("expense_management");
  
  cy.task("log", "✅ PROGRESS: - Verified ExpenseManagementScreen successfully!\n");

  });
});
