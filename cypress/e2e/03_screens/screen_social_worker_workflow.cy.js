// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - social_worker_workflow", () => {
  it("opens and verifies screen social_worker_workflow", () => {
    cy.loginAsRole("social_worker");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/clinical/roles/social_worker/workflow (SocialWorkerWorkflowScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/social_worker/workflow");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for SocialWorkerWorkflowScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("socialworkerworkflow-screen").should("be.visible");
  cy.getCy("socialworkerworkflow-title").should("be.visible");
  cy.getCy("socialworkerworkflow-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for SocialWorkerWorkflowScreen...");
  cy.waitAndSee();
  cy.screenshot("social_worker_workflow");
  
  cy.task("log", "✅ PROGRESS: - Verified SocialWorkerWorkflowScreen successfully!\n");

  });
});
