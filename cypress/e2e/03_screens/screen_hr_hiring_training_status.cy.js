// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - hr_hiring_training_status", () => {
  it("opens and verifies screen hr_hiring_training_status", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Hr Hiring Training Status)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Hr Hiring Training Status...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  // No screen_root data-cy found
  // No page_title data-cy found
  // No primary_content data-cy found

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Hr Hiring Training Status...");
  cy.waitAndSee();
  cy.screenshot("hr_hiring_training_status");
  
  cy.task("log", "✅ PROGRESS: - Verified Hr Hiring Training Status successfully!\n");

  });
});
