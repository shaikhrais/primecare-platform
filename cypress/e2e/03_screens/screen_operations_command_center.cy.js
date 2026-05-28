// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - operations_command_center", () => {
  it("opens and verifies screen operations_command_center", () => {
    cy.loginAsRole("coo");

  cy.visitWithSemantics("/executive/operations-command-center");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("operationscommandcenter-screen").should("be.visible");
  cy.getCy("operationscommandcenter-title").should("be.visible");
  cy.getCy("operationscommandcenter-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("operations_command_center");

  });
});
