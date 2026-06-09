// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - course_assignment", () => {
  it("opens and verifies screen course_assignment", () => {
    cy.loginAsRole("training_coordinator");

  cy.task("log", "⏳ PROGRESS: - Navigating to /staff/course-assignment (CourseAssignmentScreen)...");
  cy.visitWithSemantics("/staff/course-assignment");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for CourseAssignmentScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("courseassignment-screen").should("be.visible");
  cy.getCy("courseassignment-title").should("be.visible");
  cy.getCy("courseassignment-content").should("be.visible");
  cy.getCy("training-dashboard-metrics").should("be.visible");
  cy.getCy("training-feedback-submit").should("be.visible");
  cy.getCy("training-compliance-status").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for CourseAssignmentScreen...");
  cy.waitAndSee();
  cy.screenshot("course_assignment");
  
  cy.task("log", "✅ PROGRESS: - Verified CourseAssignmentScreen successfully!\n");

  });
});
