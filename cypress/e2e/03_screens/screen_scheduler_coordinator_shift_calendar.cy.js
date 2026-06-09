// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - scheduler_coordinator_shift_calendar", () => {
  it("opens and verifies screen scheduler_coordinator_shift_calendar", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/franchise/roles/scheduler_coordinator/shift-calendar (Scheduler Coordinator Shift Calendar)...");
  cy.visitWithSemantics("/offices/franchise/roles/scheduler_coordinator/shift-calendar");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Scheduler Coordinator Shift Calendar...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("schedulercoordinatorshiftcalendar-screen").should("be.visible");
  cy.getCy("schedulercoordinatorshiftcalendar-title").should("be.visible");
  cy.getCy("schedulercoordinatorshiftcalendar-content").should("be.visible");
  cy.getCy("scheduler-btn-update-shift").should("be.visible");
  cy.getCy("scheduler-btn-notify-staff").should("be.visible");
  cy.getCy("scheduler-btn-view-availability").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Scheduler Coordinator Shift Calendar...");
  cy.waitAndSee();
  cy.screenshot("scheduler_coordinator_shift_calendar");
  
  cy.task("log", "✅ PROGRESS: - Verified Scheduler Coordinator Shift Calendar successfully!\n");

  });
});
