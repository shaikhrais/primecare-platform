// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - general_manager_workflow", () => {
  it("opens and verifies screen general_manager_workflow", () => {
    cy.loginAsRole("gm");

  cy.task("log", "⏳ PROGRESS: - Navigating to /management/general-manager-workflow (GeneralManagerWorkflowScreen)...");
  cy.visitWithSemantics("/management/general-manager-workflow");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for GeneralManagerWorkflowScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("generalmanagerworkflow-screen").should("be.visible");
  cy.getCy("generalmanagerworkflow-title").should("be.visible");
  cy.getCy("generalmanagerworkflow-content").should("be.visible");
  cy.getCy("gm-dashboard-kpi-chart").should("be.visible");
  cy.getCy("gm-dashboard-financial-performance").should("be.visible");
  cy.getCy("gm-dashboard-employee-engagement").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for GeneralManagerWorkflowScreen...");
  cy.waitAndSee();
  cy.screenshot("general_manager_workflow");
  
  cy.task("log", "✅ PROGRESS: - Verified GeneralManagerWorkflowScreen successfully!\n");

  });
});
