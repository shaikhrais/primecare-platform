// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - physiotherapist_workflow", () => {
  it("opens and verifies screen physiotherapist_workflow", () => {
    cy.loginAsRole("physio");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/clinical/roles/physiotherapist/workflow (PhysiotherapistWorkflowScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/physiotherapist/workflow");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for PhysiotherapistWorkflowScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("physiotherapistworkflow-screen").should("be.visible");
  cy.getCy("physiotherapistworkflow-title").should("be.visible");
  cy.getCy("physiotherapistworkflow-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for PhysiotherapistWorkflowScreen...");
  cy.waitAndSee();
  cy.screenshot("physiotherapist_workflow");
  
  cy.task("log", "✅ PROGRESS: - Verified PhysiotherapistWorkflowScreen successfully!\n");

  });
});
