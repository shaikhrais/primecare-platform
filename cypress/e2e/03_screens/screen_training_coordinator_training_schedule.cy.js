// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - training_coordinator_training_schedule", () => {
  it("opens and verifies screen training_coordinator_training_schedule", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Training Coordinator Training Schedule)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Training Coordinator Training Schedule...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  // No screen_root data-cy found
  // No page_title data-cy found
  // No primary_content data-cy found

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Training Coordinator Training Schedule...");
  cy.waitAndSee();
  cy.screenshot("training_coordinator_training_schedule");
  
  cy.task("log", "✅ PROGRESS: - Verified Training Coordinator Training Schedule successfully!\n");

  });
});
