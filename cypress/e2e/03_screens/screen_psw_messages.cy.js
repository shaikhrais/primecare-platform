// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - psw_messages", () => {
  it("opens and verifies screen psw_messages", () => {
    cy.loginAsRole("psw");

  cy.visitWithSemantics("/psw/psw-messages");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("pswmessages-screen").should("be.visible");
  cy.getCy("pswmessages-title").should("be.visible");
  cy.getCy("pswmessages-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("psw_messages");

  });
});
