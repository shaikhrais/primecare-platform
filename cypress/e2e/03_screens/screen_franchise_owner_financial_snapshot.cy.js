// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - franchise_owner_financial_snapshot", () => {
  it("opens and verifies screen franchise_owner_financial_snapshot", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Franchise Owner Financial Snapshot)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Franchise Owner Financial Snapshot...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  // No screen_root data-cy found
  // No page_title data-cy found
  // No primary_content data-cy found

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Franchise Owner Financial Snapshot...");
  cy.waitAndSee();
  cy.screenshot("franchise_owner_financial_snapshot");
  
  cy.task("log", "✅ PROGRESS: - Verified Franchise Owner Financial Snapshot successfully!\n");

  });
});
