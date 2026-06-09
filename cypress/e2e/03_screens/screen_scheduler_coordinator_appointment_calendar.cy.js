// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - scheduler_coordinator_appointment_calendar", () => {
  it("opens and verifies screen scheduler_coordinator_appointment_calendar", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/franchise/roles/scheduler_coordinator/appointment-calendar (Scheduler Coordinator Appointment Calendar)...");
  cy.visitWithSemantics("/offices/franchise/roles/scheduler_coordinator/appointment-calendar");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Scheduler Coordinator Appointment Calendar...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("schedulercoordinatorappointmentcalendar-screen").should("be.visible");
  cy.getCy("schedulercoordinatorappointmentcalendar-title").should("be.visible");
  cy.getCy("schedulercoordinatorappointmentcalendar-content").should("be.visible");
  cy.getCy("scheduler-btn-add-appointment").should("be.visible");
  cy.getCy("scheduler-btn-edit-appointment").should("be.visible");
  cy.getCy("scheduler-btn-delete-appointment").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Scheduler Coordinator Appointment Calendar...");
  cy.waitAndSee();
  cy.screenshot("scheduler_coordinator_appointment_calendar");
  
  cy.task("log", "✅ PROGRESS: - Verified Scheduler Coordinator Appointment Calendar successfully!\n");

  });
});
