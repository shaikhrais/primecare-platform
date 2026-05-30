// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - pending_task_queue", () => {
  it("opens and verifies screen pending_task_queue", () => {
    cy.loginAsRole("governance");

  cy.task("log", "⏳ PROGRESS: - Navigating to /common/pending-task-queue (PendingTaskQueueScreen)...");
  cy.visitWithSemantics("/common/pending-task-queue");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for PendingTaskQueueScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("pendingtaskqueue-screen").should("be.visible");
  cy.getCy("pendingtaskqueue-title").should("be.visible");
  cy.getCy("pendingtaskqueue-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for PendingTaskQueueScreen...");
  cy.waitAndSee();
  cy.screenshot("pending_task_queue");
  
  cy.task("log", "✅ PROGRESS: - Verified PendingTaskQueueScreen successfully!\n");

  });
});
