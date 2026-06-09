// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - finance_director_workflow", () => {
  it("opens and verifies screen finance_director_workflow", () => {
    cy.loginAsRole("finance_director");

  cy.task("log", "⏳ PROGRESS: - Navigating to /executive/finance-director-workflow (FinanceDirectorWorkflowScreen)...");
  cy.visitWithSemantics("/executive/finance-director-workflow");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for FinanceDirectorWorkflowScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("financedirectorworkflow-screen").should("be.visible");
  cy.getCy("financedirectorworkflow-title").should("be.visible");
  cy.getCy("financedirectorworkflow-content").should("be.visible");
  cy.getCy("finance-kpi-widget").should("be.visible");
  cy.getCy("finance-cashflow-monitor").should("be.visible");
  cy.getCy("finance-budget-tracker").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for FinanceDirectorWorkflowScreen...");
  cy.waitAndSee();
  cy.screenshot("finance_director_workflow");
  
  cy.task("log", "✅ PROGRESS: - Verified FinanceDirectorWorkflowScreen successfully!\n");

  });
});
