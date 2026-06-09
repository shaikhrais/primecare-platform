// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - patient_my_appointments", () => {
  it("opens and verifies screen patient_my_appointments", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/client/roles/client/my-appointments (Patient My Appointments)...");
  cy.visitWithSemantics("/offices/client/roles/client/my-appointments");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Patient My Appointments...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("patientmyappointments-screen").should("be.visible");
  cy.getCy("patientmyappointments-title").should("be.visible");
  cy.getCy("patientmyappointments-content").should("be.visible");
  cy.getCy("appointments-list").should("be.visible");
  cy.getCy("btn-cancel-appointment").should("be.visible");
  cy.getCy("btn-reschedule-appointment").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Patient My Appointments...");
  cy.waitAndSee();
  cy.screenshot("patient_my_appointments");
  
  cy.task("log", "✅ PROGRESS: - Verified Patient My Appointments successfully!\n");

  });
});
