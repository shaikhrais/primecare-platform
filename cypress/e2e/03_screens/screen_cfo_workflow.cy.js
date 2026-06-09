// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - cfo_workflow", () => {
  it("opens and verifies screen cfo_workflow", () => {
    cy.loginAsRole("cfo");

  cy.task("log", "⏳ PROGRESS: - Navigating to /executive/cfo-workflow (CfoWorkflowScreen)...");
  cy.visitWithSemantics("/executive/cfo-workflow");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for CfoWorkflowScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("cfoworkflow-screen").should("be.visible");
  cy.getCy("cfoworkflow-title").should("be.visible");
  cy.getCy("cfoworkflow-content").should("be.visible");
  cy.getCy("cfo-dashboard-kpi-widget").should("be.visible");
  cy.getCy("cfo-dashboard-budget-analysis").should("be.visible");
  cy.getCy("cfo-dashboard-cash-flow").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for CfoWorkflowScreen...");
  cy.waitAndSee();
  cy.screenshot("cfo_workflow");
  
  cy.task("log", "✅ PROGRESS: - Verified CfoWorkflowScreen successfully!\n");

  });
});
