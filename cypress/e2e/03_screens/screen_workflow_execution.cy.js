// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - workflow_execution", () => {
  it("opens and verifies screen workflow_execution", () => {
    cy.loginAsRole("governance");

  cy.visitWithSemantics("/common/workflow-execution");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("workflowexecution-screen").should("be.visible");
  cy.getCy("workflowexecution-title").should("be.visible");
  cy.getCy("workflowexecution-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("workflow_execution");

  });
});
