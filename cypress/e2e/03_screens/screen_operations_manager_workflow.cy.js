// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - operations_manager_workflow", () => {
  it("opens and verifies screen operations_manager_workflow", () => {
    cy.loginAsRole("ops_manager");

  cy.task("log", "⏳ PROGRESS: - Navigating to /management/operations-manager-workflow (OperationsManagerWorkflowScreen)...");
  cy.visitWithSemantics("/management/operations-manager-workflow");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for OperationsManagerWorkflowScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("operationsmanagerworkflow-screen").should("be.visible");
  cy.getCy("operationsmanagerworkflow-title").should("be.visible");
  cy.getCy("operationsmanagerworkflow-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for OperationsManagerWorkflowScreen...");
  cy.waitAndSee();
  cy.screenshot("operations_manager_workflow");
  
  cy.task("log", "✅ PROGRESS: - Verified OperationsManagerWorkflowScreen successfully!\n");

  });
});
