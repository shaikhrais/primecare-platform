// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - receptionist_visitors", () => {
  it("opens and verifies screen receptionist_visitors", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Receptionist Visitors)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Receptionist Visitors...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  // No screen_root data-cy found
  // No page_title data-cy found
  // No primary_content data-cy found

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Receptionist Visitors...");
  cy.waitAndSee();
  cy.screenshot("receptionist_visitors");
  
  cy.task("log", "✅ PROGRESS: - Verified Receptionist Visitors successfully!\n");

  });
});
