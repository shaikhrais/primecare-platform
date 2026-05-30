// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - rmt_workflow", () => {
  it("opens and verifies screen rmt_workflow", () => {
    cy.loginAsRole("rmt");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/clinical/roles/rmt/workflow (RmtWorkflowScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/rmt/workflow");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for RmtWorkflowScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("rmtworkflow-screen").should("be.visible");
  cy.getCy("rmtworkflow-title").should("be.visible");
  cy.getCy("rmtworkflow-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for RmtWorkflowScreen...");
  cy.waitAndSee();
  cy.screenshot("rmt_workflow");
  
  cy.task("log", "✅ PROGRESS: - Verified RmtWorkflowScreen successfully!\n");

  });
});
