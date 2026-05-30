// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - training_director_compliance", () => {
  it("opens and verifies screen training_director_compliance", () => {
    cy.loginAsRole("training");

  cy.task("log", "⏳ PROGRESS: - Navigating to /executive/training-director-compliance (TrainingDirectorComplianceScreen)...");
  cy.visitWithSemantics("/executive/training-director-compliance");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for TrainingDirectorComplianceScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("trainingdirectorcompliance-screen").should("be.visible");
  cy.getCy("trainingdirectorcompliance-title").should("be.visible");
  cy.getCy("trainingdirectorcompliance-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for TrainingDirectorComplianceScreen...");
  cy.waitAndSee();
  cy.screenshot("training_director_compliance");
  
  cy.task("log", "✅ PROGRESS: - Verified TrainingDirectorComplianceScreen successfully!\n");

  });
});
