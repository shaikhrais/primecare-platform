// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - patient_workflow", () => {
  it("opens and verifies screen patient_workflow", () => {
    cy.loginAsRole("patient");

  cy.task("log", "⏳ PROGRESS: - Navigating to /common/patient-workflow (PatientWorkflowScreen)...");
  cy.visitWithSemantics("/common/patient-workflow");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for PatientWorkflowScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("patientworkflow-screen").should("be.visible");
  cy.getCy("patientworkflow-title").should("be.visible");
  cy.getCy("patientworkflow-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for PatientWorkflowScreen...");
  cy.waitAndSee();
  cy.screenshot("patient_workflow");
  
  cy.task("log", "✅ PROGRESS: - Verified PatientWorkflowScreen successfully!\n");

  });
});
