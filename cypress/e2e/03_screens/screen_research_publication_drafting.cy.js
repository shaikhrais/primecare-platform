// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - research_publication_drafting", () => {
  it("opens and verifies screen research_publication_drafting", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Research Publication Drafting)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Research Publication Drafting...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  // No screen_root data-cy found
  // No page_title data-cy found
  // No primary_content data-cy found

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Research Publication Drafting...");
  cy.waitAndSee();
  cy.screenshot("research_publication_drafting");
  
  cy.task("log", "✅ PROGRESS: - Verified Research Publication Drafting successfully!\n");

  });
});
