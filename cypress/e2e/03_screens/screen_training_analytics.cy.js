// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - training_analytics", () => {
  it("opens and verifies screen training_analytics", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Training Analytics)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Training Analytics...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("traininganalytics-screen").should("be.visible");
  cy.getCy("traininganalytics-title").should("be.visible");
  cy.getCy("traininganalytics-content").should("be.visible");
  cy.getCy("training-analytics-chart").should("be.visible");
  cy.getCy("engagement-metrics-card").should("be.visible");
  cy.getCy("trend-analysis-widget").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Training Analytics...");
  cy.waitAndSee();
  cy.screenshot("training_analytics");
  
  cy.task("log", "✅ PROGRESS: - Verified Training Analytics successfully!\n");

  });
});
