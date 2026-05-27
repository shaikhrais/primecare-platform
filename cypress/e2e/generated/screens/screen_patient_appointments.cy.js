// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - patient_appointments", () => {
  it("opens and verifies screen patient_appointments", () => {
    cy.loginAsRole("patient");

  cy.visit("/common/patient-appointments");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("patientappointments-screen").should("be.visible");
  cy.getCy("patientappointments-title").should("be.visible");
  cy.getCy("patientappointments-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("patient_appointments");

  });
});
