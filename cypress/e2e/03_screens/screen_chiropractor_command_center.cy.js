// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - chiropractor_command_center", () => {
  it("opens and verifies screen chiropractor_command_center", () => {
    cy.loginAsRole("chiropractor");

  cy.visitWithSemantics("/allied/chiropractor-command-center");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("chiropractorcommandcenter-screen").should("be.visible");
  cy.getCy("chiropractorcommandcenter-title").should("be.visible");
  cy.getCy("chiropractorcommandcenter-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("chiropractor_command_center");

  });
});
