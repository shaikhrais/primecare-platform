// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - patient_appointments", () => {
  it("opens and verifies screen patient_appointments", () => {
    cy.loginAsRole("patient");

  cy.task("log", "⏳ PROGRESS: - Navigating to /common/patient-appointments (PatientAppointmentsScreen)...");
  cy.visitWithSemantics("/common/patient-appointments");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for PatientAppointmentsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("patientappointments-screen").should("be.visible");
  cy.getCy("patientappointments-title").should("be.visible");
  cy.getCy("patientappointments-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for PatientAppointmentsScreen...");
  cy.waitAndSee();
  cy.screenshot("patient_appointments");
  
  cy.task("log", "✅ PROGRESS: - Verified PatientAppointmentsScreen successfully!\n");

  });
});
