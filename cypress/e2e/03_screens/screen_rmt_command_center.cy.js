// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - rmt_command_center", () => {
  it("opens and verifies screen rmt_command_center", () => {
    cy.loginAsRole("rmt");

  cy.visitWithSemantics("/allied/rmt-command-center");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("rmtcommandcenter-screen").should("be.visible");
  cy.getCy("rmtcommandcenter-title").should("be.visible");
  cy.getCy("rmtcommandcenter-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("rmt_command_center");

  });
});
