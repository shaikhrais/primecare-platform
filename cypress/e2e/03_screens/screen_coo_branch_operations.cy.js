// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - coo_branch_operations", () => {
  it("opens and verifies screen coo_branch_operations", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Coo Branch Operations)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Coo Branch Operations...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  // No screen_root data-cy found
  // No page_title data-cy found
  // No primary_content data-cy found

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Coo Branch Operations...");
  cy.waitAndSee();
  cy.screenshot("coo_branch_operations");
  
  cy.task("log", "✅ PROGRESS: - Verified Coo Branch Operations successfully!\n");

  });
});
