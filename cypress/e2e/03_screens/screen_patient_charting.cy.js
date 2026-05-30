// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - patient_charting", () => {
  it("opens and verifies screen patient_charting", () => {
    cy.loginAsRole("rn");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/clinical/roles/rn/patient-charting (PatientChartingScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/rn/patient-charting");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for PatientChartingScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("patientcharting-screen").should("be.visible");
  cy.getCy("patientcharting-title").should("be.visible");
  cy.getCy("patientcharting-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for PatientChartingScreen...");
  cy.waitAndSee();
  cy.screenshot("patient_charting");
  
  cy.task("log", "✅ PROGRESS: - Verified PatientChartingScreen successfully!\n");

  });
});
