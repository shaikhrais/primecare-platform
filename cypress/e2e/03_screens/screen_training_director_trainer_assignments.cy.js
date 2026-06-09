// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - training_director_trainer_assignments", () => {
  it("opens and verifies screen training_director_trainer_assignments", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/corporate/roles/training_director/trainer-assignments (Training Director Trainer Assignments)...");
  cy.visitWithSemantics("/offices/corporate/roles/training_director/trainer-assignments");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Training Director Trainer Assignments...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("trainingdirectortrainerassignments-screen").should("be.visible");
  cy.getCy("trainingdirectortrainerassignments-title").should("be.visible");
  cy.getCy("trainingdirectortrainerassignments-content").should("be.visible");
  cy.getCy("trainer-assignments-list").should("be.visible");
  cy.getCy("assign-trainer-btn").should("be.visible");
  cy.getCy("update-trainer-btn").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Training Director Trainer Assignments...");
  cy.waitAndSee();
  cy.screenshot("training_director_trainer_assignments");
  
  cy.task("log", "✅ PROGRESS: - Verified Training Director Trainer Assignments successfully!\n");

  });
});
