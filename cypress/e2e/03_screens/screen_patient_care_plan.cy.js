// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - patient_care_plan", () => {
  it("opens and verifies screen patient_care_plan", () => {
    cy.loginAsRole("patient");

  cy.task("log", "⏳ PROGRESS: - Navigating to /common/patient-care-plan (PatientCarePlanScreen)...");
  cy.visitWithSemantics("/common/patient-care-plan");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for PatientCarePlanScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("patientcareplan-screen").should("be.visible");
  cy.getCy("patientcareplan-title").should("be.visible");
  cy.getCy("patientcareplan-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for PatientCarePlanScreen...");
  cy.waitAndSee();
  cy.screenshot("patient_care_plan");
  
  cy.task("log", "✅ PROGRESS: - Verified PatientCarePlanScreen successfully!\n");

  });
});
