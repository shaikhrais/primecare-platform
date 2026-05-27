// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - rn_command_center", () => {
  it("opens and verifies screen rn_command_center", () => {
    cy.loginAsRole("rn");

  cy.visit("/rn/rn-command-center");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("rncommandcenter-screen").should("be.visible");
  cy.getCy("rncommandcenter-title").should("be.visible");
  cy.getCy("rncommandcenter-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("rn_command_center");

  });
});
