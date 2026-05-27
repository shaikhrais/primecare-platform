// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - psw_clients", () => {
  it("opens and verifies screen psw_clients", () => {
    cy.loginAsRole("psw");

  cy.visit("/psw/psw-clients");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("pswclients-screen").should("be.visible");
  cy.getCy("pswclients-title").should("be.visible");
  cy.getCy("pswclients-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("psw_clients");

  });
});
