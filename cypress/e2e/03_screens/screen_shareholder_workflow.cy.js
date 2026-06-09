// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - shareholder_workflow", () => {
  it("opens and verifies screen shareholder_workflow", () => {
    cy.loginAsRole("shareholder");

  cy.task("log", "⏳ PROGRESS: - Navigating to /executive/shareholder-workflow (ShareholderWorkflowScreen)...");
  cy.visitWithSemantics("/executive/shareholder-workflow");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for ShareholderWorkflowScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("shareholderworkflow-screen").should("be.visible");
  cy.getCy("shareholderworkflow-title").should("be.visible");
  cy.getCy("shareholderworkflow-content").should("be.visible");
  cy.getCy("shareholder-dashboard-compliance-metric").should("be.visible");
  cy.getCy("shareholder-dashboard-log-viewer").should("be.visible");
  cy.getCy("shareholder-dashboard-workflow-status").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for ShareholderWorkflowScreen...");
  cy.waitAndSee();
  cy.screenshot("shareholder_workflow");
  
  cy.task("log", "✅ PROGRESS: - Verified ShareholderWorkflowScreen successfully!\n");

  });
});
