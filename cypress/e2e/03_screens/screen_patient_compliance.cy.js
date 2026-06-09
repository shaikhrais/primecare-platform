// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - patient_compliance", () => {
  it("opens and verifies screen patient_compliance", () => {
    cy.loginAsRole("patient");

  cy.task("log", "⏳ PROGRESS: - Navigating to /common/patient-compliance (PatientComplianceScreen)...");
  cy.visitWithSemantics("/common/patient-compliance");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for PatientComplianceScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("patientcompliance-screen").should("be.visible");
  cy.getCy("patientcompliance-title").should("be.visible");
  cy.getCy("patientcompliance-content").should("be.visible");
  cy.getCy("compliance-status-overview").should("be.visible");
  cy.getCy("audit-results-chart").should("be.visible");
  cy.getCy("governance-directives-log").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for PatientComplianceScreen...");
  cy.waitAndSee();
  cy.screenshot("patient_compliance");
  
  cy.task("log", "✅ PROGRESS: - Verified PatientComplianceScreen successfully!\n");

  });
});
