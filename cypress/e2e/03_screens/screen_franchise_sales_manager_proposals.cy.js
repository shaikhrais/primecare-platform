// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - franchise_sales_manager_proposals", () => {
  it("opens and verifies screen franchise_sales_manager_proposals", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Franchise Sales Manager Proposals)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Franchise Sales Manager Proposals...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  // No screen_root data-cy found
  // No page_title data-cy found
  // No primary_content data-cy found

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Franchise Sales Manager Proposals...");
  cy.waitAndSee();
  cy.screenshot("franchise_sales_manager_proposals");
  
  cy.task("log", "✅ PROGRESS: - Verified Franchise Sales Manager Proposals successfully!\n");

  });
});
