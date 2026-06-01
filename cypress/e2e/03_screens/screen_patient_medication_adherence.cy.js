// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - patient_medication_adherence", () => {
  it("opens and verifies screen patient_medication_adherence", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Patient Medication Adherence)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Patient Medication Adherence...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  // No screen_root data-cy found
  // No page_title data-cy found
  // No primary_content data-cy found

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Patient Medication Adherence...");
  cy.waitAndSee();
  cy.screenshot("patient_medication_adherence");
  
  cy.task("log", "✅ PROGRESS: - Verified Patient Medication Adherence successfully!\n");

  });
});
