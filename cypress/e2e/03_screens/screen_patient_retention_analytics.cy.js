// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - patient_retention_analytics", () => {
  it("opens and verifies screen patient_retention_analytics", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Patient Retention Analytics)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Patient Retention Analytics...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  // No screen_root data-cy found
  // No page_title data-cy found
  // No primary_content data-cy found

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Patient Retention Analytics...");
  cy.waitAndSee();
  cy.screenshot("patient_retention_analytics");
  
  cy.task("log", "✅ PROGRESS: - Verified Patient Retention Analytics successfully!\n");

  });
});
