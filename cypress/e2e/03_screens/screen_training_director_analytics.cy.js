// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - training_director_analytics", () => {
  it("opens and verifies screen training_director_analytics", () => {
    cy.loginAsRole("training");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/corporate/roles/training_director/analytics (TrainingDirectorAnalyticsScreen)...");
  cy.visitWithSemantics("/offices/corporate/roles/training_director/analytics");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for TrainingDirectorAnalyticsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("trainingdirectoranalytics-screen").should("be.visible");
  cy.getCy("trainingdirectoranalytics-title").should("be.visible");
  cy.getCy("trainingdirectoranalytics-content").should("be.visible");
  cy.getCy("training-progress-tracker").should("be.visible");
  cy.getCy("training-assessment-submit").should("be.visible");
  cy.getCy("training-attendance-record").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for TrainingDirectorAnalyticsScreen...");
  cy.waitAndSee();
  cy.screenshot("training_director_analytics");
  
  cy.task("log", "✅ PROGRESS: - Verified TrainingDirectorAnalyticsScreen successfully!\n");

  });
});
