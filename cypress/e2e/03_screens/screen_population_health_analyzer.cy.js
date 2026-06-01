// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - population_health_analyzer", () => {
  it("opens and verifies screen population_health_analyzer", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Population Health Analyzer)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Population Health Analyzer...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  // No screen_root data-cy found
  // No page_title data-cy found
  // No primary_content data-cy found

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Population Health Analyzer...");
  cy.waitAndSee();
  cy.screenshot("population_health_analyzer");
  
  cy.task("log", "✅ PROGRESS: - Verified Population Health Analyzer successfully!\n");

  });
});
