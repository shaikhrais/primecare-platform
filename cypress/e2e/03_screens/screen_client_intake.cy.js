// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - client_intake", () => {
  it("opens and verifies screen client_intake", () => {
    cy.loginAsRole("intake");

  cy.visitWithSemantics("/executive/client-intake");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("clientintake-screen").should("be.visible");
  cy.getCy("clientintake-title").should("be.visible");
  cy.getCy("clientintake-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("client_intake");

  });
});
