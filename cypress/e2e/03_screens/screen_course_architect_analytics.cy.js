// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - course_architect_analytics", () => {
  it("opens and verifies screen course_architect_analytics", () => {
    cy.loginAsRole("training_director");

  cy.task("log", "⏳ PROGRESS: - Navigating to /common/course-architect-analytics (CourseArchitectAnalyticsScreen)...");
  cy.visitWithSemantics("/common/course-architect-analytics");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for CourseArchitectAnalyticsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("coursearchitectanalytics-screen").should("be.visible");
  cy.getCy("coursearchitectanalytics-title").should("be.visible");
  cy.getCy("coursearchitectanalytics-content").should("be.visible");
  cy.getCy("training-participation-metric").should("be.visible");
  cy.getCy("feedback-score-card").should("be.visible");
  cy.getCy("effectiveness-metric-chart").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for CourseArchitectAnalyticsScreen...");
  cy.waitAndSee();
  cy.screenshot("course_architect_analytics");
  
  cy.task("log", "✅ PROGRESS: - Verified CourseArchitectAnalyticsScreen successfully!\n");

  });
});
