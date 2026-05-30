// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - architecture_planning_workflow", () => {
  it("opens and verifies screen architecture_planning_workflow", () => {
    cy.loginAsRole("infrastructure");

  cy.task("log", "⏳ PROGRESS: - Navigating to /common/architecture-planning-workflow (ArchitecturePlanningWorkflowScreen)...");
  cy.visitWithSemantics("/common/architecture-planning-workflow");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for ArchitecturePlanningWorkflowScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("architectureplanningworkflow-screen").should("be.visible");
  cy.getCy("architectureplanningworkflow-title").should("be.visible");
  cy.getCy("architectureplanningworkflow-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for ArchitecturePlanningWorkflowScreen...");
  cy.waitAndSee();
  cy.screenshot("architecture_planning_workflow");
  
  cy.task("log", "✅ PROGRESS: - Verified ArchitecturePlanningWorkflowScreen successfully!\n");

  });
});
