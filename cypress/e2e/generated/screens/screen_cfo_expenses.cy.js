// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - cfo_expenses", () => {
  it("opens and verifies screen cfo_expenses", () => {
    cy.loginAsRole("cfo");

  cy.visit("/executive/cfo-expenses");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("cfoexpenses-screen").should("be.visible");
  cy.getCy("cfoexpenses-title").should("be.visible");
  cy.getCy("cfoexpenses-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("cfo_expenses");

  });
});
