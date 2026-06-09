// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - course_architect_compliance", () => {
  it("opens and verifies screen course_architect_compliance", () => {
    cy.loginAsRole("training_director");

  cy.task("log", "⏳ PROGRESS: - Navigating to /common/course-architect-compliance (CourseArchitectComplianceScreen)...");
  cy.visitWithSemantics("/common/course-architect-compliance");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for CourseArchitectComplianceScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("coursearchitectcompliance-screen").should("be.visible");
  cy.getCy("coursearchitectcompliance-title").should("be.visible");
  cy.getCy("coursearchitectcompliance-content").should("be.visible");
  cy.getCy("trainingprogram-card").should("be.visible");
  cy.getCy("feedback-chart").should("be.visible");
  cy.getCy("compliance-status-widget").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for CourseArchitectComplianceScreen...");
  cy.waitAndSee();
  cy.screenshot("course_architect_compliance");
  
  cy.task("log", "✅ PROGRESS: - Verified CourseArchitectComplianceScreen successfully!\n");

  });
});
