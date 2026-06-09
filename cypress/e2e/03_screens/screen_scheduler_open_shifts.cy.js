// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - scheduler_open_shifts", () => {
  it("opens and verifies screen scheduler_open_shifts", () => {
    cy.loginAsRole("scheduler");

  cy.task("log", "⏳ PROGRESS: - Navigating to /staff/scheduler-open-shifts (SchedulerOpenShiftsScreen)...");
  cy.visitWithSemantics("/staff/scheduler-open-shifts");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for SchedulerOpenShiftsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("scheduleropenshifts-screen").should("be.visible");
  cy.getCy("scheduleropenshifts-title").should("be.visible");
  cy.getCy("scheduleropenshifts-content").should("be.visible");
  cy.getCy("scheduler-btn-view-performance").should("be.visible");
  cy.getCy("scheduler-btn-conduct-audit").should("be.visible");
  cy.getCy("scheduler-btn-update-schedule").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for SchedulerOpenShiftsScreen...");
  cy.waitAndSee();
  cy.screenshot("scheduler_open_shifts");
  
  cy.task("log", "✅ PROGRESS: - Verified SchedulerOpenShiftsScreen successfully!\n");

  });
});
