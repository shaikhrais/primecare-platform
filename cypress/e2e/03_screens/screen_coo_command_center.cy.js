// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - coo_command_center", () => {
  it("opens and verifies screen coo_command_center", () => {
    cy.loginAsRole("coo");

  cy.visitWithSemantics("/executive/coo-command-center");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("coocommandcenter-screen").should("be.visible");
  cy.getCy("coocommandcenter-title").should("be.visible");
  cy.getCy("coocommandcenter-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("coo_command_center");

  });
});
