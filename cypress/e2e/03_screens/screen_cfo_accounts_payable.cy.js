// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - cfo_accounts_payable", () => {
  it("opens and verifies screen cfo_accounts_payable", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Cfo Accounts Payable)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Cfo Accounts Payable...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  // No screen_root data-cy found
  // No page_title data-cy found
  // No primary_content data-cy found

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Cfo Accounts Payable...");
  cy.waitAndSee();
  cy.screenshot("cfo_accounts_payable");
  
  cy.task("log", "✅ PROGRESS: - Verified Cfo Accounts Payable successfully!\n");

  });
});
