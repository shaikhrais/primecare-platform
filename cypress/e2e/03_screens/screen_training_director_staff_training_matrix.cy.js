// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - training_director_staff_training_matrix", () => {
  it("opens and verifies screen training_director_staff_training_matrix", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Training Director Staff Training Matrix)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Training Director Staff Training Matrix...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  // No screen_root data-cy found
  // No page_title data-cy found
  // No primary_content data-cy found

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Training Director Staff Training Matrix...");
  cy.waitAndSee();
  cy.screenshot("training_director_staff_training_matrix");
  
  cy.task("log", "✅ PROGRESS: - Verified Training Director Staff Training Matrix successfully!\n");

  });
});
