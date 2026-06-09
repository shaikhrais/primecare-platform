// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - scheduler_coordinator_booking_requests", () => {
  it("opens and verifies screen scheduler_coordinator_booking_requests", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/franchise/roles/scheduler_coordinator/booking-requests (Scheduler Coordinator Booking Requests)...");
  cy.visitWithSemantics("/offices/franchise/roles/scheduler_coordinator/booking-requests");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Scheduler Coordinator Booking Requests...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("schedulercoordinatorbookingrequests-screen").should("be.visible");
  cy.getCy("schedulercoordinatorbookingrequests-title").should("be.visible");
  cy.getCy("schedulercoordinatorbookingrequests-content").should("be.visible");
  cy.getCy("booking-request-list").should("be.visible");
  cy.getCy("btn-approve").should("be.visible");
  cy.getCy("btn-reject").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Scheduler Coordinator Booking Requests...");
  cy.waitAndSee();
  cy.screenshot("scheduler_coordinator_booking_requests");
  
  cy.task("log", "✅ PROGRESS: - Verified Scheduler Coordinator Booking Requests successfully!\n");

  });
});
