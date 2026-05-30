// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - chiropractor_exercise_plan", () => {
  it("opens and verifies screen chiropractor_exercise_plan", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/clinical/roles/chiropractor/exercise-plan (ChiropractorExercisePlanScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/chiropractor/exercise-plan");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for ChiropractorExercisePlanScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("chiropractorexerciseplan-screen").should("be.visible");
  cy.getCy("chiropractorexerciseplan-title").should("be.visible");
  cy.getCy("chiropractorexerciseplan-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for ChiropractorExercisePlanScreen...");
  cy.waitAndSee();
  cy.screenshot("chiropractor_exercise_plan");
  
  cy.task("log", "✅ PROGRESS: - Verified ChiropractorExercisePlanScreen successfully!\n");

  });
});
