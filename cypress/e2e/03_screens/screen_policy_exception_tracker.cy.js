// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - policy_exception_tracker", () => {
  it("opens and verifies screen policy_exception_tracker", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Policy Exception Tracker)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Policy Exception Tracker...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  // No screen_root data-cy found
  // No page_title data-cy found
  // No primary_content data-cy found

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Policy Exception Tracker...");
  cy.waitAndSee();
  cy.screenshot("policy_exception_tracker");
  
  cy.task("log", "✅ PROGRESS: - Verified Policy Exception Tracker successfully!\n");

  });
});
