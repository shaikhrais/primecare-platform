// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - patient_documents", () => {
  it("opens and verifies screen patient_documents", () => {
    cy.loginAsRole("patient");

  cy.task("log", "⏳ PROGRESS: - Navigating to /common/patient-documents (PatientDocumentsScreen)...");
  cy.visitWithSemantics("/common/patient-documents");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for PatientDocumentsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("patientdocuments-screen").should("be.visible");
  cy.getCy("patientdocuments-title").should("be.visible");
  cy.getCy("patientdocuments-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for PatientDocumentsScreen...");
  cy.waitAndSee();
  cy.screenshot("patient_documents");
  
  cy.task("log", "✅ PROGRESS: - Verified PatientDocumentsScreen successfully!\n");

  });
});
