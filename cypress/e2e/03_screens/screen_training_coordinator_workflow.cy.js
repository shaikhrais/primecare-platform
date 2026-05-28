// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - training_coordinator_workflow", () => {
  it("opens and verifies screen training_coordinator_workflow", () => {
    cy.loginAsRole("training");

  cy.visitWithSemantics("/staff/training-coordinator-workflow");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("trainingcoordinatorworkflow-screen").should("be.visible");
  cy.getCy("trainingcoordinatorworkflow-title").should("be.visible");
  cy.getCy("trainingcoordinatorworkflow-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("training_coordinator_workflow");

  });
});
