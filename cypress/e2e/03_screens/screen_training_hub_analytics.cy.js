// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - training_hub_analytics", () => {
  it("opens and verifies screen training_hub_analytics", () => {
    cy.loginAsRole("training");

  cy.task("log", "⏳ PROGRESS: - Navigating to /common/training-hub-analytics (TrainingHubAnalyticsScreen)...");
  cy.visitWithSemantics("/common/training-hub-analytics");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for TrainingHubAnalyticsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("traininghubanalytics-screen").should("be.visible");
  cy.getCy("traininghubanalytics-title").should("be.visible");
  cy.getCy("traininghubanalytics-content").should("be.visible");
  cy.getCy("training-progress-tracker").should("be.visible");
  cy.getCy("training-engagement-stats").should("be.visible");
  cy.getCy("training-assessment-scores").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for TrainingHubAnalyticsScreen...");
  cy.waitAndSee();
  cy.screenshot("training_hub_analytics");
  
  cy.task("log", "✅ PROGRESS: - Verified TrainingHubAnalyticsScreen successfully!\n");

  });
});
