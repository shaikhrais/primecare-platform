// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - qa_workflow", () => {
  it("opens and verifies screen qa_workflow", () => {
    cy.loginAsRole("qa_specialist");

  cy.task("log", "⏳ PROGRESS: - Navigating to /common/qa-workflow (QaWorkflowScreen)...");
  cy.visitWithSemantics("/common/qa-workflow");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for QaWorkflowScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("qaworkflow-screen").should("be.visible");
  cy.getCy("qaworkflow-title").should("be.visible");
  cy.getCy("qaworkflow-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for QaWorkflowScreen...");
  cy.waitAndSee();
  cy.screenshot("qa_workflow");
  
  cy.task("log", "✅ PROGRESS: - Verified QaWorkflowScreen successfully!\n");

  });
});
