// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - ceo_enterprise_overview", () => {
  it("opens and verifies screen ceo_enterprise_overview", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Ceo Enterprise Overview)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Ceo Enterprise Overview...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  // No screen_root data-cy found
  // No page_title data-cy found
  // No primary_content data-cy found

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Ceo Enterprise Overview...");
  cy.waitAndSee();
  cy.screenshot("ceo_enterprise_overview");
  
  cy.task("log", "✅ PROGRESS: - Verified Ceo Enterprise Overview successfully!\n");

  });
});
