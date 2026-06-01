// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - vulnerable_population_registry", () => {
  it("opens and verifies screen vulnerable_population_registry", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Vulnerable Population Registry)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Vulnerable Population Registry...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  // No screen_root data-cy found
  // No page_title data-cy found
  // No primary_content data-cy found

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Vulnerable Population Registry...");
  cy.waitAndSee();
  cy.screenshot("vulnerable_population_registry");
  
  cy.task("log", "✅ PROGRESS: - Verified Vulnerable Population Registry successfully!\n");

  });
});
