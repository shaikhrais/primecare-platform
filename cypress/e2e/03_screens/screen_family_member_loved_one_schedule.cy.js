// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - family_member_loved_one_schedule", () => {
  it("opens and verifies screen family_member_loved_one_schedule", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Family Member Loved One Schedule)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Family Member Loved One Schedule...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  // No screen_root data-cy found
  // No page_title data-cy found
  // No primary_content data-cy found

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Family Member Loved One Schedule...");
  cy.waitAndSee();
  cy.screenshot("family_member_loved_one_schedule");
  
  cy.task("log", "✅ PROGRESS: - Verified Family Member Loved One Schedule successfully!\n");

  });
});
