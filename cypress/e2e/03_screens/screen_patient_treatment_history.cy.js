// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - patient_treatment_history", () => {
  it("opens and verifies screen patient_treatment_history", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/client/roles/client/treatment-history (Patient Treatment History)...");
  cy.visitWithSemantics("/offices/client/roles/client/treatment-history");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Patient Treatment History...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("patienttreatmenthistory-screen").should("be.visible");
  cy.getCy("patienttreatmenthistory-title").should("be.visible");
  cy.getCy("patienttreatmenthistory-content").should("be.visible");
  cy.getCy("patient-history-view").should("be.visible");
  cy.getCy("loading-indicator").should("be.visible");
  cy.getCy("error-notification").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Patient Treatment History...");
  cy.waitAndSee();
  cy.screenshot("patient_treatment_history");
  
  cy.task("log", "✅ PROGRESS: - Verified Patient Treatment History successfully!\n");

  });
});
