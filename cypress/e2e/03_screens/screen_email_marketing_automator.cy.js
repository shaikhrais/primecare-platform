// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - email_marketing_automator", () => {
  it("opens and verifies screen email_marketing_automator", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Email Marketing Automator)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Email Marketing Automator...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  // No screen_root data-cy found
  // No page_title data-cy found
  // No primary_content data-cy found

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Email Marketing Automator...");
  cy.waitAndSee();
  cy.screenshot("email_marketing_automator");
  
  cy.task("log", "✅ PROGRESS: - Verified Email Marketing Automator successfully!\n");

  });
});
