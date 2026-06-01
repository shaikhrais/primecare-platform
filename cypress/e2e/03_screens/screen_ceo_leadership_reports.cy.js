// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - ceo_leadership_reports", () => {
  it("opens and verifies screen ceo_leadership_reports", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Ceo Leadership Reports)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Ceo Leadership Reports...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  // No screen_root data-cy found
  // No page_title data-cy found
  // No primary_content data-cy found

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Ceo Leadership Reports...");
  cy.waitAndSee();
  cy.screenshot("ceo_leadership_reports");
  
  cy.task("log", "✅ PROGRESS: - Verified Ceo Leadership Reports successfully!\n");

  });
});
