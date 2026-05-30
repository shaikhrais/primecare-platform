// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - patient_analytics", () => {
  it("opens and verifies screen patient_analytics", () => {
    cy.loginAsRole("patient");

  cy.task("log", "⏳ PROGRESS: - Navigating to /common/patient-analytics (PatientAnalyticsScreen)...");
  cy.visitWithSemantics("/common/patient-analytics");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for PatientAnalyticsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("patientanalytics-screen").should("be.visible");
  cy.getCy("patientanalytics-title").should("be.visible");
  cy.getCy("patientanalytics-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for PatientAnalyticsScreen...");
  cy.waitAndSee();
  cy.screenshot("patient_analytics");
  
  cy.task("log", "✅ PROGRESS: - Verified PatientAnalyticsScreen successfully!\n");

  });
});
