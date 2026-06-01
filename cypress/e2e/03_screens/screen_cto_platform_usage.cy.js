// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - cto_platform_usage", () => {
  it("opens and verifies screen cto_platform_usage", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Cto Platform Usage)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Cto Platform Usage...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  // No screen_root data-cy found
  // No page_title data-cy found
  // No primary_content data-cy found

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Cto Platform Usage...");
  cy.waitAndSee();
  cy.screenshot("cto_platform_usage");
  
  cy.task("log", "✅ PROGRESS: - Verified Cto Platform Usage successfully!\n");

  });
});
