// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - expense_management", () => {
  it("opens and verifies screen expense_management", () => {
    cy.loginAsRole("cfo");

  cy.visit("/executive/expense-management");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("expensemanagement-screen").should("be.visible");
  cy.getCy("expensemanagement-title").should("be.visible");
  cy.getCy("expensemanagement-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("expense_management");

  });
});
