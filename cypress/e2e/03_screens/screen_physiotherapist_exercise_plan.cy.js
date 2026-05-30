// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - physiotherapist_exercise_plan", () => {
  it("opens and verifies screen physiotherapist_exercise_plan", () => {
    cy.loginAsRole("physio");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/clinical/roles/physiotherapist/exercise-plan (PhysiotherapistExercisePlanScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/physiotherapist/exercise-plan");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for PhysiotherapistExercisePlanScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("physiotherapistexerciseplan-screen").should("be.visible");
  cy.getCy("physiotherapistexerciseplan-title").should("be.visible");
  cy.getCy("physiotherapistexerciseplan-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for PhysiotherapistExercisePlanScreen...");
  cy.waitAndSee();
  cy.screenshot("physiotherapist_exercise_plan");
  
  cy.task("log", "✅ PROGRESS: - Verified PhysiotherapistExercisePlanScreen successfully!\n");

  });
});
