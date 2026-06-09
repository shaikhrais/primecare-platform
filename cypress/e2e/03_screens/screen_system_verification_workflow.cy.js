// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - system_verification_workflow", () => {
  it("opens and verifies screen system_verification_workflow", () => {
    cy.loginAsRole("system_verification");

  cy.task("log", "⏳ PROGRESS: - Navigating to /common/system-verification-workflow (SystemVerificationWorkflowScreen)...");
  cy.visitWithSemantics("/common/system-verification-workflow");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for SystemVerificationWorkflowScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("systemverificationworkflow-screen").should("be.visible");
  cy.getCy("systemverificationworkflow-title").should("be.visible");
  cy.getCy("systemverificationworkflow-content").should("be.visible");
  cy.getCy("sysverif-btn-review").should("be.visible");
  cy.getCy("sysverif-btn-validate").should("be.visible");
  cy.getCy("sysverif-btn-audit").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for SystemVerificationWorkflowScreen...");
  cy.waitAndSee();
  cy.screenshot("system_verification_workflow");
  
  cy.task("log", "✅ PROGRESS: - Verified SystemVerificationWorkflowScreen successfully!\n");

  });
});
