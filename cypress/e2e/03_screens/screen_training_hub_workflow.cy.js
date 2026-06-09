// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - training_hub_workflow", () => {
  it("opens and verifies screen training_hub_workflow", () => {
    cy.loginAsRole("training");

  cy.task("log", "⏳ PROGRESS: - Navigating to /common/training-hub-workflow (TrainingHubWorkflowScreen)...");
  cy.visitWithSemantics("/common/training-hub-workflow");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for TrainingHubWorkflowScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("traininghubworkflow-screen").should("be.visible");
  cy.getCy("traininghubworkflow-title").should("be.visible");
  cy.getCy("traininghubworkflow-content").should("be.visible");
  cy.getCy("training-progress-tracker").should("be.visible");
  cy.getCy("training-assessment-score").should("be.visible");
  cy.getCy("training-event-calendar").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for TrainingHubWorkflowScreen...");
  cy.waitAndSee();
  cy.screenshot("training_hub_workflow");
  
  cy.task("log", "✅ PROGRESS: - Verified TrainingHubWorkflowScreen successfully!\n");

  });
});
