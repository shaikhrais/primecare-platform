// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - head_of_marketing_regional_campaigns", () => {
  it("opens and verifies screen head_of_marketing_regional_campaigns", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Head Of Marketing Regional Campaigns)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Head Of Marketing Regional Campaigns...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  // No screen_root data-cy found
  // No page_title data-cy found
  // No primary_content data-cy found

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Head Of Marketing Regional Campaigns...");
  cy.waitAndSee();
  cy.screenshot("head_of_marketing_regional_campaigns");
  
  cy.task("log", "✅ PROGRESS: - Verified Head Of Marketing Regional Campaigns successfully!\n");

  });
});
