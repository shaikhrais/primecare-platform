// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - exercise_prescription", () => {
  it("opens and verifies screen exercise_prescription", () => {
    cy.loginAsRole("physio");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/clinical/roles/physiotherapist/exercise-prescription (ExercisePrescriptionScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/physiotherapist/exercise-prescription");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for ExercisePrescriptionScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("exerciseprescription-screen").should("be.visible");
  cy.getCy("exerciseprescription-title").should("be.visible");
  cy.getCy("exerciseprescription-content").should("be.visible");
  cy.getCy("pswdashboard-btn-update-status").should("be.visible");
  cy.getCy("pswdashboard-btn-log-compliance").should("be.visible");
  cy.getCy("pswdashboard-btn-view-kpis").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for ExercisePrescriptionScreen...");
  cy.waitAndSee();
  cy.screenshot("exercise_prescription");
  
  cy.task("log", "✅ PROGRESS: - Verified ExercisePrescriptionScreen successfully!\n");

  });
});
