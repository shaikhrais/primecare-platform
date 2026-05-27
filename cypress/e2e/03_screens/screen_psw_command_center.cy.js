// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - psw_command_center", () => {
  it("opens and verifies screen psw_command_center", () => {
    cy.loginAsRole("psw");

  cy.visit("/psw/psw-command-center");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("pswcommandcenter-screen").should("be.visible");
  cy.getCy("pswcommandcenter-title").should("be.visible");
  cy.getCy("pswcommandcenter-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("psw_command_center");

  });
});
