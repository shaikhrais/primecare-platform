// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - patient_command_center", () => {
  it("opens and verifies screen patient_command_center", () => {
    cy.loginAsRole("patient");

  cy.task("log", "⏳ PROGRESS: - Navigating to /common/patient-command-center (PatientCommandCenterScreen)...");
  cy.visitWithSemantics("/common/patient-command-center");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for PatientCommandCenterScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("patientcommandcenter-screen").should("be.visible");
  cy.getCy("patientcommandcenter-title").should("be.visible");
  cy.getCy("patientcommandcenter-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for PatientCommandCenterScreen...");
  cy.waitAndSee();
  cy.screenshot("patient_command_center");
  
  cy.task("log", "✅ PROGRESS: - Verified PatientCommandCenterScreen successfully!\n");

  });
});
