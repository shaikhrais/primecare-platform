// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - training_director_staff_training_matrix", () => {
  it("opens and verifies screen training_director_staff_training_matrix", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/corporate/roles/training_director/staff-training-matrix (Training Director Staff Training Matrix)...");
  cy.visitWithSemantics("/offices/corporate/roles/training_director/staff-training-matrix");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Training Director Staff Training Matrix...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("trainingdirectorstafftrainingmatrix-screen").should("be.visible");
  cy.getCy("trainingdirectorstafftrainingmatrix-title").should("be.visible");
  cy.getCy("trainingdirectorstafftrainingmatrix-content").should("be.visible");
  cy.getCy("training-matrix-review").should("be.visible");
  cy.getCy("training-completion-status").should("be.visible");
  cy.getCy("training-needs-identification").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Training Director Staff Training Matrix...");
  cy.waitAndSee();
  cy.screenshot("training_director_staff_training_matrix");
  
  cy.task("log", "✅ PROGRESS: - Verified Training Director Staff Training Matrix successfully!\n");

  });
});
