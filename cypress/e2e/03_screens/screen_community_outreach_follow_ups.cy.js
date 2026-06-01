// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - community_outreach_follow_ups", () => {
  it("opens and verifies screen community_outreach_follow_ups", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Community Outreach Follow Ups)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Community Outreach Follow Ups...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  // No screen_root data-cy found
  // No page_title data-cy found
  // No primary_content data-cy found

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Community Outreach Follow Ups...");
  cy.waitAndSee();
  cy.screenshot("community_outreach_follow_ups");
  
  cy.task("log", "✅ PROGRESS: - Verified Community Outreach Follow Ups successfully!\n");

  });
});
