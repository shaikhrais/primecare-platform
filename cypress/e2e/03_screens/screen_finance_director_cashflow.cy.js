// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - finance_director_cashflow", () => {
  it("opens and verifies screen finance_director_cashflow", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Finance Director Cashflow)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Finance Director Cashflow...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  // No screen_root data-cy found
  // No page_title data-cy found
  // No primary_content data-cy found

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Finance Director Cashflow...");
  cy.waitAndSee();
  cy.screenshot("finance_director_cashflow");
  
  cy.task("log", "✅ PROGRESS: - Verified Finance Director Cashflow successfully!\n");

  });
});
