// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - rpn_command_center", () => {
  it("opens and verifies screen rpn_command_center", () => {
    cy.loginAsRole("rpn");

  cy.visitWithSemantics("/rpn/rpn-command-center");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("rpncommandcenter-screen").should("be.visible");
  cy.getCy("rpncommandcenter-title").should("be.visible");
  cy.getCy("rpncommandcenter-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("rpn_command_center");

  });
});
