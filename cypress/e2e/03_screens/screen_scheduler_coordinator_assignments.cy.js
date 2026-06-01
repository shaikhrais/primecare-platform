// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - scheduler_coordinator_assignments", () => {
  it("opens and verifies screen scheduler_coordinator_assignments", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Scheduler Coordinator Assignments)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Scheduler Coordinator Assignments...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  // No screen_root data-cy found
  // No page_title data-cy found
  // No primary_content data-cy found

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Scheduler Coordinator Assignments...");
  cy.waitAndSee();
  cy.screenshot("scheduler_coordinator_assignments");
  
  cy.task("log", "✅ PROGRESS: - Verified Scheduler Coordinator Assignments successfully!\n");

  });
});
