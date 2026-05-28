// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - physiotherapist_command_center", () => {
  it("opens and verifies screen physiotherapist_command_center", () => {
    cy.loginAsRole("physio");

  cy.visitWithSemantics("/allied/physiotherapist-command-center");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("physiotherapistcommandcenter-screen").should("be.visible");
  cy.getCy("physiotherapistcommandcenter-title").should("be.visible");
  cy.getCy("physiotherapistcommandcenter-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("physiotherapist_command_center");

  });
});
