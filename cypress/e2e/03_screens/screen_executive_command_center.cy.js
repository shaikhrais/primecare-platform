// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - executive_command_center", () => {
  it("opens and verifies screen executive_command_center", () => {
    cy.loginAsRole("ceo");

  cy.visit("/executive/executive-command-center");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("executivecommandcenter-screen").should("be.visible");
  cy.getCy("executivecommandcenter-title").should("be.visible");
  cy.getCy("executivecommandcenter-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("executive_command_center");

  });
});
