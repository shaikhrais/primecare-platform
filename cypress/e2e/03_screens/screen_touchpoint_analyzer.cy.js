// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - touchpoint_analyzer", () => {
  it("opens and verifies screen touchpoint_analyzer", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Touchpoint Analyzer)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Touchpoint Analyzer...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  // No screen_root data-cy found
  // No page_title data-cy found
  // No primary_content data-cy found

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Touchpoint Analyzer...");
  cy.waitAndSee();
  cy.screenshot("touchpoint_analyzer");
  
  cy.task("log", "✅ PROGRESS: - Verified Touchpoint Analyzer successfully!\n");

  });
});
