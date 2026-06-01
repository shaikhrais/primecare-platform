// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - regional_bdm_franchise_pipeline", () => {
  it("opens and verifies screen regional_bdm_franchise_pipeline", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Regional Bdm Franchise Pipeline)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Regional Bdm Franchise Pipeline...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  // No screen_root data-cy found
  // No page_title data-cy found
  // No primary_content data-cy found

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Regional Bdm Franchise Pipeline...");
  cy.waitAndSee();
  cy.screenshot("regional_bdm_franchise_pipeline");
  
  cy.task("log", "✅ PROGRESS: - Verified Regional Bdm Franchise Pipeline successfully!\n");

  });
});
