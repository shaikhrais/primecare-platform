// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - cfo_accounts_receivable", () => {
  it("opens and verifies screen cfo_accounts_receivable", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Cfo Accounts Receivable)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Cfo Accounts Receivable...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  // No screen_root data-cy found
  // No page_title data-cy found
  // No primary_content data-cy found

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Cfo Accounts Receivable...");
  cy.waitAndSee();
  cy.screenshot("cfo_accounts_receivable");
  
  cy.task("log", "✅ PROGRESS: - Verified Cfo Accounts Receivable successfully!\n");

  });
});
