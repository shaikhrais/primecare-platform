// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - simulation_lab_scheduler", () => {
  it("opens and verifies screen simulation_lab_scheduler", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Simulation Lab Scheduler)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Simulation Lab Scheduler...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  // No screen_root data-cy found
  // No page_title data-cy found
  // No primary_content data-cy found

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Simulation Lab Scheduler...");
  cy.waitAndSee();
  cy.screenshot("simulation_lab_scheduler");
  
  cy.task("log", "✅ PROGRESS: - Verified Simulation Lab Scheduler successfully!\n");

  });
});
