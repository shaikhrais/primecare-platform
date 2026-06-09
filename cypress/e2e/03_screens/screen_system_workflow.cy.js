// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - system_workflow", () => {
  it("opens and verifies screen system_workflow", () => {
    cy.loginAsRole("system_verification");

  cy.task("log", "⏳ PROGRESS: - Navigating to /common/system-workflow (SystemWorkflowScreen)...");
  cy.visitWithSemantics("/common/system-workflow");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for SystemWorkflowScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("systemworkflow-screen").should("be.visible");
  cy.getCy("systemworkflow-title").should("be.visible");
  cy.getCy("systemworkflow-content").should("be.visible");
  cy.getCy("sysworkflow-btn-generate-report").should("be.visible");
  cy.getCy("sysworkflow-btn-request-support").should("be.visible");
  cy.getCy("sysworkflow-btn-update-docs").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for SystemWorkflowScreen...");
  cy.waitAndSee();
  cy.screenshot("system_workflow");
  
  cy.task("log", "✅ PROGRESS: - Verified SystemWorkflowScreen successfully!\n");

  });
});
