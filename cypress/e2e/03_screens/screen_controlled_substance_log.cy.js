// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - controlled_substance_log", () => {
  it("opens and verifies screen controlled_substance_log", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Controlled Substance Log)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Controlled Substance Log...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  // No screen_root data-cy found
  // No page_title data-cy found
  // No primary_content data-cy found

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Controlled Substance Log...");
  cy.waitAndSee();
  cy.screenshot("controlled_substance_log");
  
  cy.task("log", "✅ PROGRESS: - Verified Controlled Substance Log successfully!\n");

  });
});
