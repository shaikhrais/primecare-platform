// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - workflow_execution", () => {
  it("opens and verifies screen workflow_execution", () => {
    cy.loginAsRole("governance");

  cy.task("log", "⏳ PROGRESS: - Navigating to /common/workflow-execution (WorkflowExecutionScreen)...");
  cy.visitWithSemantics("/common/workflow-execution");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for WorkflowExecutionScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("workflowexecution-screen").should("be.visible");
  cy.getCy("workflowexecution-title").should("be.visible");
  cy.getCy("workflowexecution-content").should("be.visible");
  cy.getCy("gov-dashboard-btn-view-audit-logs").should("be.visible");
  cy.getCy("gov-dashboard-btn-generate-report").should("be.visible");
  cy.getCy("gov-dashboard-btn-request-training").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for WorkflowExecutionScreen...");
  cy.waitAndSee();
  cy.screenshot("workflow_execution");
  
  cy.task("log", "✅ PROGRESS: - Verified WorkflowExecutionScreen successfully!\n");

  });
});
