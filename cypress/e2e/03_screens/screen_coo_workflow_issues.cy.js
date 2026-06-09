// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - coo_workflow_issues", () => {
  it("opens and verifies screen coo_workflow_issues", () => {
    cy.loginAsRole("coo");

  cy.task("log", "⏳ PROGRESS: - Navigating to /executive/coo-workflow-issues (CooWorkflowIssuesScreen)...");
  cy.visitWithSemantics("/executive/coo-workflow-issues");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for CooWorkflowIssuesScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("cooworkflowissues-screen").should("be.visible");
  cy.getCy("cooworkflowissues-title").should("be.visible");
  cy.getCy("cooworkflowissues-content").should("be.visible");
  cy.getCy("coo-dashboard-kpi-overview").should("be.visible");
  cy.getCy("coo-dashboard-metrics").should("be.visible");
  cy.getCy("coo-dashboard-compliance-status").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for CooWorkflowIssuesScreen...");
  cy.waitAndSee();
  cy.screenshot("coo_workflow_issues");
  
  cy.task("log", "✅ PROGRESS: - Verified CooWorkflowIssuesScreen successfully!\n");

  });
});
