// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - patient_observation", () => {
  it("opens and verifies screen patient_observation", () => {
    cy.loginAsRole("rpn");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/clinical/roles/rpn/patient-observation (PatientObservationScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/rpn/patient-observation");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for PatientObservationScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("patientobservation-screen").should("be.visible");
  cy.getCy("patientobservation-title").should("be.visible");
  cy.getCy("patientobservation-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for PatientObservationScreen...");
  cy.waitAndSee();
  cy.screenshot("patient_observation");
  
  cy.task("log", "✅ PROGRESS: - Verified PatientObservationScreen successfully!\n");

  });
});
