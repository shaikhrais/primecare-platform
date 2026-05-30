// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - rn_patient_charting", () => {
  it("opens and verifies screen rn_patient_charting", () => {
    cy.loginAsRole("rn");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/clinical/roles/rn/patient-charting (RnPatientChartingScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/rn/patient-charting");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for RnPatientChartingScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("rnpatientcharting-screen").should("be.visible");
  cy.getCy("rnpatientcharting-title").should("be.visible");
  cy.getCy("rnpatientcharting-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for RnPatientChartingScreen...");
  cy.waitAndSee();
  cy.screenshot("rn_patient_charting");
  
  cy.task("log", "✅ PROGRESS: - Verified RnPatientChartingScreen successfully!\n");

  });
});
