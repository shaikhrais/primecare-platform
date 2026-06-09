// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - patient_medication_adherence", () => {
  it("opens and verifies screen patient_medication_adherence", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Patient Medication Adherence)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Patient Medication Adherence...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("patientmedicationadherence-screen").should("be.visible");
  cy.getCy("patientmedicationadherence-title").should("be.visible");
  cy.getCy("patientmedicationadherence-content").should("be.visible");
  cy.getCy("patient-adherence-overview").should("be.visible");
  cy.getCy("patient-list-table").should("be.visible");
  cy.getCy("missed-reminders-alert").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Patient Medication Adherence...");
  cy.waitAndSee();
  cy.screenshot("patient_medication_adherence");
  
  cy.task("log", "✅ PROGRESS: - Verified Patient Medication Adherence successfully!\n");

  });
});
