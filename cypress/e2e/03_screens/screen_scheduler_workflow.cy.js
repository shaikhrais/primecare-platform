// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - scheduler_workflow", () => {
  it("opens and verifies screen scheduler_workflow", () => {
    cy.loginAsRole("scheduler");

  cy.task("log", "⏳ PROGRESS: - Navigating to /staff/scheduler-workflow (SchedulerWorkflowScreen)...");
  cy.visitWithSemantics("/staff/scheduler-workflow");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for SchedulerWorkflowScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("schedulerworkflow-screen").should("be.visible");
  cy.getCy("schedulerworkflow-title").should("be.visible");
  cy.getCy("schedulerworkflow-content").should("be.visible");
  cy.getCy("scheduler-btn-update-schedule").should("be.visible");
  cy.getCy("scheduler-btn-submit-incident").should("be.visible");
  cy.getCy("scheduler-btn-view-feedback").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for SchedulerWorkflowScreen...");
  cy.waitAndSee();
  cy.screenshot("scheduler_workflow");
  
  cy.task("log", "✅ PROGRESS: - Verified SchedulerWorkflowScreen successfully!\n");

  });
});
