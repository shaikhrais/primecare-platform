// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - patient_billing", () => {
  it("opens and verifies screen patient_billing", () => {
    cy.loginAsRole("patient");

  cy.task("log", "⏳ PROGRESS: - Navigating to /common/patient-billing (PatientBillingScreen)...");
  cy.visitWithSemantics("/common/patient-billing");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for PatientBillingScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("patientbilling-screen").should("be.visible");
  cy.getCy("patientbilling-title").should("be.visible");
  cy.getCy("patientbilling-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for PatientBillingScreen...");
  cy.waitAndSee();
  cy.screenshot("patient_billing");
  
  cy.task("log", "✅ PROGRESS: - Verified PatientBillingScreen successfully!\n");

  });
});
