// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - intake_coordinator_booking", () => {
  it("opens and verifies screen intake_coordinator_booking", () => {
    cy.loginAsRole("volunteer_coordinator");

  cy.task("log", "⏳ PROGRESS: - Navigating to /executive/intake-coordinator-booking (IntakeCoordinatorBookingScreen)...");
  cy.visitWithSemantics("/executive/intake-coordinator-booking");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for IntakeCoordinatorBookingScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("intakecoordinatorbooking-screen").should("be.visible");
  cy.getCy("intakecoordinatorbooking-title").should("be.visible");
  cy.getCy("intakecoordinatorbooking-content").should("be.visible");
  cy.getCy("volunteer-dashboard-btn-add").should("be.visible");
  cy.getCy("volunteer-dashboard-btn-schedule").should("be.visible");
  cy.getCy("volunteer-dashboard-btn-log-hours").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for IntakeCoordinatorBookingScreen...");
  cy.waitAndSee();
  cy.screenshot("intake_coordinator_booking");
  
  cy.task("log", "✅ PROGRESS: - Verified IntakeCoordinatorBookingScreen successfully!\n");

  });
});
