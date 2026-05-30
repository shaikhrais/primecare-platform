// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - hr_director_training", () => {
  it("opens and verifies screen hr_director_training", () => {
    cy.loginAsRole("hr_director");

  cy.task("log", "⏳ PROGRESS: - Navigating to /executive/hr-director-training (HrDirectorTrainingScreen)...");
  cy.visitWithSemantics("/executive/hr-director-training");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for HrDirectorTrainingScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("hrdirectortraining-screen").should("be.visible");
  cy.getCy("hrdirectortraining-title").should("be.visible");
  cy.getCy("hrdirectortraining-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for HrDirectorTrainingScreen...");
  cy.waitAndSee();
  cy.screenshot("hr_director_training");
  
  cy.task("log", "✅ PROGRESS: - Verified HrDirectorTrainingScreen successfully!\n");

  });
});
