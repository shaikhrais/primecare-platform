// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - patient_case_study_repository", () => {
  it("opens and verifies screen patient_case_study_repository", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Patient Case Study Repository)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Patient Case Study Repository...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  // No screen_root data-cy found
  // No page_title data-cy found
  // No primary_content data-cy found

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Patient Case Study Repository...");
  cy.waitAndSee();
  cy.screenshot("patient_case_study_repository");
  
  cy.task("log", "✅ PROGRESS: - Verified Patient Case Study Repository successfully!\n");

  });
});
