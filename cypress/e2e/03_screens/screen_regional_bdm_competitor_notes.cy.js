// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - regional_bdm_competitor_notes", () => {
  it("opens and verifies screen regional_bdm_competitor_notes", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Regional Bdm Competitor Notes)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Regional Bdm Competitor Notes...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  // No screen_root data-cy found
  // No page_title data-cy found
  // No primary_content data-cy found

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Regional Bdm Competitor Notes...");
  cy.waitAndSee();
  cy.screenshot("regional_bdm_competitor_notes");
  
  cy.task("log", "✅ PROGRESS: - Verified Regional Bdm Competitor Notes successfully!\n");

  });
});
