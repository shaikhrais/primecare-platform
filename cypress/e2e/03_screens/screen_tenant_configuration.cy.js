// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - tenant_configuration", () => {
  it("opens and verifies screen tenant_configuration", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Tenant Configuration)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Tenant Configuration...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  // No screen_root data-cy found
  // No page_title data-cy found
  // No primary_content data-cy found

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Tenant Configuration...");
  cy.waitAndSee();
  cy.screenshot("tenant_configuration");
  
  cy.task("log", "✅ PROGRESS: - Verified Tenant Configuration successfully!\n");

  });
});
