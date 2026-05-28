// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - financial_operations4_k", () => {
  it("opens and verifies screen financial_operations4_k", () => {
    cy.loginAsRole("cfo");

  cy.visitWithSemantics("/executive/financial-operations4-k");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("financialoperations4k-screen").should("be.visible");
  cy.getCy("financialoperations4k-title").should("be.visible");
  cy.getCy("financialoperations4k-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("financial_operations4_k");

  });
});
