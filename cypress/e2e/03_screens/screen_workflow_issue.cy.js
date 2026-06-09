// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - workflow_issue", () => {
  it("opens and verifies screen workflow_issue", () => {
    cy.loginAsRole("coo");

  cy.task("log", "⏳ PROGRESS: - Navigating to /executive/workflow-issue (WorkflowIssueScreen)...");
  cy.visitWithSemantics("/executive/workflow-issue");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for WorkflowIssueScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("workflowissue-screen").should("be.visible");
  cy.getCy("workflowissue-title").should("be.visible");
  cy.getCy("workflowissue-content").should("be.visible");
  cy.getCy("coo-dashboard-kpi").should("be.visible");
  cy.getCy("coo-dashboard-financials").should("be.visible");
  cy.getCy("coo-dashboard-compliance").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for WorkflowIssueScreen...");
  cy.waitAndSee();
  cy.screenshot("workflow_issue");
  
  cy.task("log", "✅ PROGRESS: - Verified WorkflowIssueScreen successfully!\n");

  });
});
