// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - rmt_client_intake", () => {
  it("opens and verifies screen rmt_client_intake", () => {
    cy.loginAsRole("rmt");

  cy.visit("/allied/rmt-client-intake");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("rmtclientintake-screen").should("be.visible");
  cy.getCy("rmtclientintake-title").should("be.visible");
  cy.getCy("rmtclientintake-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("rmt_client_intake");

  });
});
