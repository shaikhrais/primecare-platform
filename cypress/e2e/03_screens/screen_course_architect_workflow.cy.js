// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - course_architect_workflow", () => {
  it("opens and verifies screen course_architect_workflow", () => {
    cy.loginAsRole("training_director");

  cy.task("log", "⏳ PROGRESS: - Navigating to /common/course-architect-workflow (CourseArchitectWorkflowScreen)...");
  cy.visitWithSemantics("/common/course-architect-workflow");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for CourseArchitectWorkflowScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("coursearchitectworkflow-screen").should("be.visible");
  cy.getCy("coursearchitectworkflow-title").should("be.visible");
  cy.getCy("coursearchitectworkflow-content").should("be.visible");
  cy.getCy("trainingprogram-card").should("be.visible");
  cy.getCy("feedbackscore-chart").should("be.visible");
  cy.getCy("completionrate-chart").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for CourseArchitectWorkflowScreen...");
  cy.waitAndSee();
  cy.screenshot("course_architect_workflow");
  
  cy.task("log", "✅ PROGRESS: - Verified CourseArchitectWorkflowScreen successfully!\n");

  });
});
