// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - franchise_owner_hiring", () => {
  it("opens and verifies screen franchise_owner_hiring", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Franchise Owner Hiring)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Franchise Owner Hiring...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  // No screen_root data-cy found
  // No page_title data-cy found
  // No primary_content data-cy found

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Franchise Owner Hiring...");
  cy.waitAndSee();
  cy.screenshot("franchise_owner_hiring");
  
  cy.task("log", "✅ PROGRESS: - Verified Franchise Owner Hiring successfully!\n");

  });
});
