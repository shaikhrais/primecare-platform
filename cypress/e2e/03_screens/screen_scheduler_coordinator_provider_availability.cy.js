// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - scheduler_coordinator_provider_availability", () => {
  it("opens and verifies screen scheduler_coordinator_provider_availability", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Scheduler Coordinator Provider Availability)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Scheduler Coordinator Provider Availability...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  // No screen_root data-cy found
  // No page_title data-cy found
  // No primary_content data-cy found

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Scheduler Coordinator Provider Availability...");
  cy.waitAndSee();
  cy.screenshot("scheduler_coordinator_provider_availability");
  
  cy.task("log", "✅ PROGRESS: - Verified Scheduler Coordinator Provider Availability successfully!\n");

  });
});
