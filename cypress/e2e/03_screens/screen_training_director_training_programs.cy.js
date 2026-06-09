// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - training_director_training_programs", () => {
  it("opens and verifies screen training_director_training_programs", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/corporate/roles/training_director/training-programs (Training Director Training Programs)...");
  cy.visitWithSemantics("/offices/corporate/roles/training_director/training-programs");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Training Director Training Programs...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("trainingdirectortrainingprograms-screen").should("be.visible");
  cy.getCy("trainingdirectortrainingprograms-title").should("be.visible");
  cy.getCy("trainingdirectortrainingprograms-content").should("be.visible");
  cy.getCy("trainingprograms-loading-indicator").should("be.visible");
  cy.getCy("trainingprograms-error-log").should("be.visible");
  cy.getCy("trainingprograms-feedback-section").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Training Director Training Programs...");
  cy.waitAndSee();
  cy.screenshot("training_director_training_programs");
  
  cy.task("log", "✅ PROGRESS: - Verified Training Director Training Programs successfully!\n");

  });
});
