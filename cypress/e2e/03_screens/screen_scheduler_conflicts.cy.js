// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - scheduler_conflicts", () => {
  it("opens and verifies screen scheduler_conflicts", () => {
    cy.loginAsRole("scheduler");

  cy.task("log", "⏳ PROGRESS: - Navigating to /staff/scheduler-conflicts (SchedulerConflictsScreen)...");
  cy.visitWithSemantics("/staff/scheduler-conflicts");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for SchedulerConflictsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("schedulerconflicts-screen").should("be.visible");
  cy.getCy("schedulerconflicts-title").should("be.visible");
  cy.getCy("schedulerconflicts-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for SchedulerConflictsScreen...");
  cy.waitAndSee();
  cy.screenshot("scheduler_conflicts");
  
  cy.task("log", "✅ PROGRESS: - Verified SchedulerConflictsScreen successfully!\n");

  });
});
