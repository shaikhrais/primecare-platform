// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - customer_support_issue_categories", () => {
  it("opens and verifies screen customer_support_issue_categories", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Customer Support Issue Categories)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Customer Support Issue Categories...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  // No screen_root data-cy found
  // No page_title data-cy found
  // No primary_content data-cy found

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Customer Support Issue Categories...");
  cy.waitAndSee();
  cy.screenshot("customer_support_issue_categories");
  
  cy.task("log", "✅ PROGRESS: - Verified Customer Support Issue Categories successfully!\n");

  });
});
