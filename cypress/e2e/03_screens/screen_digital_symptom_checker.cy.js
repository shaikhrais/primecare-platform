// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - digital_symptom_checker", () => {
  it("opens and verifies screen digital_symptom_checker", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Digital Symptom Checker)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Digital Symptom Checker...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  // No screen_root data-cy found
  // No page_title data-cy found
  // No primary_content data-cy found

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Digital Symptom Checker...");
  cy.waitAndSee();
  cy.screenshot("digital_symptom_checker");
  
  cy.task("log", "✅ PROGRESS: - Verified Digital Symptom Checker successfully!\n");

  });
});
