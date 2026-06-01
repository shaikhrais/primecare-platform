// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - marketing_manager_campaigns", () => {
  it("opens and verifies screen marketing_manager_campaigns", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Marketing Manager Campaigns)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Marketing Manager Campaigns...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  // No screen_root data-cy found
  // No page_title data-cy found
  // No primary_content data-cy found

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Marketing Manager Campaigns...");
  cy.waitAndSee();
  cy.screenshot("marketing_manager_campaigns");
  
  cy.task("log", "✅ PROGRESS: - Verified Marketing Manager Campaigns successfully!\n");

  });
});
