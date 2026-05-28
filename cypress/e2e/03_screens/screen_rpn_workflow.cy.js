// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - rpn_workflow", () => {
  it("opens and verifies screen rpn_workflow", () => {
    cy.loginAsRole("rpn");

  cy.visitWithSemantics("/rpn/rpn-workflow");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("rpnworkflow-screen").should("be.visible");
  cy.getCy("rpnworkflow-title").should("be.visible");
  cy.getCy("rpnworkflow-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("rpn_workflow");

  });
});
