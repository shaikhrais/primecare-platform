// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - patient_profile", () => {
  it("opens and verifies screen patient_profile", () => {
    cy.loginAsRole("patient");

  cy.task("log", "⏳ PROGRESS: - Navigating to /common/patient-profile (PatientProfileScreen)...");
  cy.visitWithSemantics("/common/patient-profile");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for PatientProfileScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("patientprofile-screen").should("be.visible");
  cy.getCy("patientprofile-title").should("be.visible");
  cy.getCy("patientprofile-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for PatientProfileScreen...");
  cy.waitAndSee();
  cy.screenshot("patient_profile");
  
  cy.task("log", "✅ PROGRESS: - Verified PatientProfileScreen successfully!\n");

  });
});
