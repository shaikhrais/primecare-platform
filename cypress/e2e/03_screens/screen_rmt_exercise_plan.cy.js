// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - rmt_exercise_plan", () => {
  it("opens and verifies screen rmt_exercise_plan", () => {
    cy.loginAsRole("rmt");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/clinical/roles/rmt/exercise-plan (RmtExercisePlanScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/rmt/exercise-plan");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for RmtExercisePlanScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("rmtexerciseplan-screen").should("be.visible");
  cy.getCy("rmtexerciseplan-title").should("be.visible");
  cy.getCy("rmtexerciseplan-content").should("be.visible");
  cy.getCy("rmt-dashboard-client-overview").should("be.visible");
  cy.getCy("rmt-dashboard-compliance-status").should("be.visible");
  cy.getCy("rmt-dashboard-feedback-metrics").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for RmtExercisePlanScreen...");
  cy.waitAndSee();
  cy.screenshot("rmt_exercise_plan");
  
  cy.task("log", "✅ PROGRESS: - Verified RmtExercisePlanScreen successfully!\n");

  });
});
