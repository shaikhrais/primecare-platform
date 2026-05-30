// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - training_director_workflow", () => {
  it("opens and verifies screen training_director_workflow", () => {
    cy.loginAsRole("training");

  cy.task("log", "⏳ PROGRESS: - Navigating to /executive/training-director-workflow (TrainingDirectorWorkflowScreen)...");
  cy.visitWithSemantics("/executive/training-director-workflow");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for TrainingDirectorWorkflowScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("trainingdirectorworkflow-screen").should("be.visible");
  cy.getCy("trainingdirectorworkflow-title").should("be.visible");
  cy.getCy("trainingdirectorworkflow-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for TrainingDirectorWorkflowScreen...");
  cy.waitAndSee();
  cy.screenshot("training_director_workflow");
  
  cy.task("log", "✅ PROGRESS: - Verified TrainingDirectorWorkflowScreen successfully!\n");

  });
});
