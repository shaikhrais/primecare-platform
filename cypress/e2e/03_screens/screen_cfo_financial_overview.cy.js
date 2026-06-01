// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - cfo_financial_overview", () => {
  it("opens and verifies screen cfo_financial_overview", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Cfo Financial Overview)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Cfo Financial Overview...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  // No screen_root data-cy found
  // No page_title data-cy found
  // No primary_content data-cy found

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Cfo Financial Overview...");
  cy.waitAndSee();
  cy.screenshot("cfo_financial_overview");
  
  cy.task("log", "✅ PROGRESS: - Verified Cfo Financial Overview successfully!\n");

  });
});
