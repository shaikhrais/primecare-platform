// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - cto_api_monitoring", () => {
  it("opens and verifies screen cto_api_monitoring", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Cto Api Monitoring)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Cto Api Monitoring...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  // No screen_root data-cy found
  // No page_title data-cy found
  // No primary_content data-cy found

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Cto Api Monitoring...");
  cy.waitAndSee();
  cy.screenshot("cto_api_monitoring");
  
  cy.task("log", "✅ PROGRESS: - Verified Cto Api Monitoring successfully!\n");

  });
});
