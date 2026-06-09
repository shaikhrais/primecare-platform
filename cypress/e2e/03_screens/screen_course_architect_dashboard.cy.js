// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - course_architect_dashboard", () => {
  it("opens and verifies screen course_architect_dashboard", () => {
    cy.loginAsRole("training_director");

  cy.task("log", "⏳ PROGRESS: - Navigating to /common/course-architect-dashboard (CourseArchitectDashboardScreen)...");
  cy.visitWithSemantics("/common/course-architect-dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for CourseArchitectDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("coursearchitectdashboard-screen").should("be.visible");
  cy.getCy("coursearchitectdashboard-title").should("be.visible");
  cy.getCy("coursearchitectdashboard-content").should("be.visible");
  cy.getCy("dashboard-participation-metric").should("be.visible");
  cy.getCy("dashboard-feedback-score").should("be.visible");
  cy.getCy("dashboard-effectiveness-data").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for CourseArchitectDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("course_architect_dashboard");
  
  cy.task("log", "✅ PROGRESS: - Verified CourseArchitectDashboardScreen successfully!\n");

  });
});
