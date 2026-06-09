// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - coo_workflow", () => {
  it("opens and verifies screen coo_workflow", () => {
    cy.loginAsRole("coo");

  cy.task("log", "⏳ PROGRESS: - Navigating to /executive/coo-workflow (CooWorkflowScreen)...");
  cy.visitWithSemantics("/executive/coo-workflow");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for CooWorkflowScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("cooworkflow-screen").should("be.visible");
  cy.getCy("cooworkflow-title").should("be.visible");
  cy.getCy("cooworkflow-content").should("be.visible");
  cy.getCy("coo-dashboard-refresh-data").should("be.visible");
  cy.getCy("coo-dashboard-export-report").should("be.visible");
  cy.getCy("coo-dashboard-set-alerts").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for CooWorkflowScreen...");
  cy.waitAndSee();
  cy.screenshot("coo_workflow");
  
  cy.task("log", "✅ PROGRESS: - Verified CooWorkflowScreen successfully!\n");

  });
});
