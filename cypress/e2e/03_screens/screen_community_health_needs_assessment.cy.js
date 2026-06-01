// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - community_health_needs_assessment", () => {
  it("opens and verifies screen community_health_needs_assessment", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Community Health Needs Assessment)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Community Health Needs Assessment...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  // No screen_root data-cy found
  // No page_title data-cy found
  // No primary_content data-cy found

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Community Health Needs Assessment...");
  cy.waitAndSee();
  cy.screenshot("community_health_needs_assessment");
  
  cy.task("log", "✅ PROGRESS: - Verified Community Health Needs Assessment successfully!\n");

  });
});
