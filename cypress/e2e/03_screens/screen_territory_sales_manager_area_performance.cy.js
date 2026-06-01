// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - territory_sales_manager_area_performance", () => {
  it("opens and verifies screen territory_sales_manager_area_performance", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Territory Sales Manager Area Performance)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Territory Sales Manager Area Performance...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  // No screen_root data-cy found
  // No page_title data-cy found
  // No primary_content data-cy found

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Territory Sales Manager Area Performance...");
  cy.waitAndSee();
  cy.screenshot("territory_sales_manager_area_performance");
  
  cy.task("log", "✅ PROGRESS: - Verified Territory Sales Manager Area Performance successfully!\n");

  });
});
