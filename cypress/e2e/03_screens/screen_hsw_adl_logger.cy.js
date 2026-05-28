// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - hsw_adl_logger", () => {
  it("opens and verifies screen hsw_adl_logger", () => {
    cy.loginAsRole("hsw");

  cy.visitWithSemantics("/clinical/hsw-adl-logger");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("hswadllogger-screen").should("be.visible");
  cy.getCy("hswadllogger-title").should("be.visible");
  cy.getCy("hswadllogger-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("hsw_adl_logger");

  });
});
