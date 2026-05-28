// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - scheduler_booking_requests", () => {
  it("opens and verifies screen scheduler_booking_requests", () => {
    cy.loginAsRole("scheduler");

  cy.visitWithSemantics("/staff/scheduler-booking-requests");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("schedulerbookingrequests-screen").should("be.visible");
  cy.getCy("schedulerbookingrequests-title").should("be.visible");
  cy.getCy("schedulerbookingrequests-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("scheduler_booking_requests");

  });
});
