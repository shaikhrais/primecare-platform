// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - rpn_reports", () => {
  it("opens and verifies screen rpn_reports", () => {
    cy.loginAsRole("rpn");

  cy.visitWithSemantics("/rpn/rpn-reports");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("rpnreports-screen").should("be.visible");
  cy.getCy("rpnreports-title").should("be.visible");
  cy.getCy("rpnreports-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("rpn_reports");

  });
});
