// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - failed_workflow", () => {
  it("opens and verifies screen failed_workflow", () => {
    cy.loginAsRole("qa_specialist");

  cy.task("log", "⏳ PROGRESS: - Navigating to /staff/failed-workflow (FailedWorkflowScreen)...");
  cy.visitWithSemantics("/staff/failed-workflow");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for FailedWorkflowScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("failedworkflow-screen").should("be.visible");
  cy.getCy("failedworkflow-title").should("be.visible");
  cy.getCy("failedworkflow-content").should("be.visible");
  cy.getCy("qa-tasklist").should("be.visible");
  cy.getCy("qa-defect-metrics").should("be.visible");
  cy.getCy("qa-test-coverage").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for FailedWorkflowScreen...");
  cy.waitAndSee();
  cy.screenshot("failed_workflow");
  
  cy.task("log", "✅ PROGRESS: - Verified FailedWorkflowScreen successfully!\n");

  });
});
