// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - physiotherapist_client_intake", () => {
  it("opens and verifies screen physiotherapist_client_intake", () => {
    cy.loginAsRole("physio");

  cy.visit("/allied/physiotherapist-client-intake");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("physiotherapistclientintake-screen").should("be.visible");
  cy.getCy("physiotherapistclientintake-title").should("be.visible");
  cy.getCy("physiotherapistclientintake-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("physiotherapist_client_intake");

  });
});
