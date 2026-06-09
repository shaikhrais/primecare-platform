// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - scheduler_booking_requests", () => {
  it("opens and verifies screen scheduler_booking_requests", () => {
    cy.loginAsRole("scheduler");

  cy.task("log", "⏳ PROGRESS: - Navigating to /staff/scheduler-booking-requests (SchedulerBookingRequestsScreen)...");
  cy.visitWithSemantics("/staff/scheduler-booking-requests");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for SchedulerBookingRequestsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("schedulerbookingrequests-screen").should("be.visible");
  cy.getCy("schedulerbookingrequests-title").should("be.visible");
  cy.getCy("schedulerbookingrequests-content").should("be.visible");
  cy.getCy("scheduler-btn-view-reports").should("be.visible");
  cy.getCy("scheduler-btn-update-schedule").should("be.visible");
  cy.getCy("scheduler-btn-resolve-complaint").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for SchedulerBookingRequestsScreen...");
  cy.waitAndSee();
  cy.screenshot("scheduler_booking_requests");
  
  cy.task("log", "✅ PROGRESS: - Verified SchedulerBookingRequestsScreen successfully!\n");

  });
});
