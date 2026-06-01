// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - partnership_manager_active_deals", () => {
  it("opens and verifies screen partnership_manager_active_deals", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Partnership Manager Active Deals)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Partnership Manager Active Deals...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  // No screen_root data-cy found
  // No page_title data-cy found
  // No primary_content data-cy found

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Partnership Manager Active Deals...");
  cy.waitAndSee();
  cy.screenshot("partnership_manager_active_deals");
  
  cy.task("log", "✅ PROGRESS: - Verified Partnership Manager Active Deals successfully!\n");

  });
});
