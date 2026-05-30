// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - scheduler_calendar", () => {
  it("opens and verifies screen scheduler_calendar", () => {
    cy.loginAsRole("scheduler");

  cy.task("log", "⏳ PROGRESS: - Navigating to /staff/scheduler-calendar (SchedulerCalendarScreen)...");
  cy.visitWithSemantics("/staff/scheduler-calendar");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for SchedulerCalendarScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("schedulercalendar-screen").should("be.visible");
  cy.getCy("schedulercalendar-title").should("be.visible");
  cy.getCy("schedulercalendar-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for SchedulerCalendarScreen...");
  cy.waitAndSee();
  cy.screenshot("scheduler_calendar");
  
  cy.task("log", "✅ PROGRESS: - Verified SchedulerCalendarScreen successfully!\n");

  });
});
