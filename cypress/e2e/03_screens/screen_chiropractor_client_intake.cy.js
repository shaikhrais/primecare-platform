// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - chiropractor_client_intake", () => {
  it("opens and verifies screen chiropractor_client_intake", () => {
    cy.loginAsRole("chiropractor");

  cy.visitWithSemantics("/allied/chiropractor-client-intake");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("chiropractorclientintake-screen").should("be.visible");
  cy.getCy("chiropractorclientintake-title").should("be.visible");
  cy.getCy("chiropractorclientintake-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("chiropractor_client_intake");

  });
});
