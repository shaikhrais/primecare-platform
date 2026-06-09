// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - regional_bdm_workflow", () => {
  it("opens and verifies screen regional_bdm_workflow", () => {
    cy.loginAsRole("regional_bdm");

  cy.task("log", "⏳ PROGRESS: - Navigating to /management/regional-bdm-workflow (RegionalBdmWorkflowScreen)...");
  cy.visitWithSemantics("/management/regional-bdm-workflow");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for RegionalBdmWorkflowScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("regionalbdmworkflow-screen").should("be.visible");
  cy.getCy("regionalbdmworkflow-title").should("be.visible");
  cy.getCy("regionalbdmworkflow-content").should("be.visible");
  cy.getCy("regional-bdm-sales-metric").should("be.visible");
  cy.getCy("regional-bdm-sales-trend").should("be.visible");
  cy.getCy("regional-bdm-client-manager").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for RegionalBdmWorkflowScreen...");
  cy.waitAndSee();
  cy.screenshot("regional_bdm_workflow");
  
  cy.task("log", "✅ PROGRESS: - Verified RegionalBdmWorkflowScreen successfully!\n");

  });
});
