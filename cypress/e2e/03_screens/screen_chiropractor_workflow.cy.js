// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - chiropractor_workflow", () => {
  it("opens and verifies screen chiropractor_workflow", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/clinical/roles/chiropractor/workflow (ChiropractorWorkflowScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/chiropractor/workflow");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for ChiropractorWorkflowScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("chiropractorworkflow-screen").should("be.visible");
  cy.getCy("chiropractorworkflow-title").should("be.visible");
  cy.getCy("chiropractorworkflow-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for ChiropractorWorkflowScreen...");
  cy.waitAndSee();
  cy.screenshot("chiropractor_workflow");
  
  cy.task("log", "✅ PROGRESS: - Verified ChiropractorWorkflowScreen successfully!\n");

  });
});
