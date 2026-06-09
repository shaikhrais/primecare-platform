// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - rmt_appointments", () => {
  it("opens and verifies screen rmt_appointments", () => {
    cy.loginAsRole("rmt");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/clinical/roles/rmt/appointments (RmtAppointmentsScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/rmt/appointments");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for RmtAppointmentsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("rmtappointments-screen").should("be.visible");
  cy.getCy("rmtappointments-title").should("be.visible");
  cy.getCy("rmtappointments-content").should("be.visible");
  cy.getCy("rmt-appointments-schedule").should("be.visible");
  cy.getCy("rmt-assessment-submit").should("be.visible");
  cy.getCy("rmt-treatment-save").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for RmtAppointmentsScreen...");
  cy.waitAndSee();
  cy.screenshot("rmt_appointments");
  
  cy.task("log", "✅ PROGRESS: - Verified RmtAppointmentsScreen successfully!\n");

  });
});
