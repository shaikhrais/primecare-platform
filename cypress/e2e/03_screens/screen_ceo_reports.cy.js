// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - ceo_reports", () => {
  it("opens and verifies screen ceo_reports", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Ceo Reports)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Ceo Reports...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  // No screen_root data-cy found
  // No page_title data-cy found
  // No primary_content data-cy found

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Ceo Reports...");
  cy.waitAndSee();
  cy.screenshot("ceo_reports");
  
  cy.task("log", "✅ PROGRESS: - Verified Ceo Reports successfully!\n");

  });
});
