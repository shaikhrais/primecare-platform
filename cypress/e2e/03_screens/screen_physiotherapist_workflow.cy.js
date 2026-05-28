// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - physiotherapist_workflow", () => {
  it("opens and verifies screen physiotherapist_workflow", () => {
    cy.loginAsRole("physio");

  cy.visitWithSemantics("/common/physiotherapist-workflow");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("physiotherapistworkflow-screen").should("be.visible");
  cy.getCy("physiotherapistworkflow-title").should("be.visible");
  cy.getCy("physiotherapistworkflow-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("physiotherapist_workflow");

  });
});
