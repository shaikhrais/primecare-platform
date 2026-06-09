// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - training_coordinator_courses", () => {
  it("opens and verifies screen training_coordinator_courses", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Training Coordinator Courses)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Training Coordinator Courses...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("trainingcoordinatorcourses-screen").should("be.visible");
  cy.getCy("trainingcoordinatorcourses-title").should("be.visible");
  cy.getCy("trainingcoordinatorcourses-content").should("be.visible");
  cy.getCy("loading-indicator").should("be.visible");
  cy.getCy("error-notification").should("be.visible");
  cy.getCy("course-summary").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Training Coordinator Courses...");
  cy.waitAndSee();
  cy.screenshot("training_coordinator_courses");
  
  cy.task("log", "✅ PROGRESS: - Verified Training Coordinator Courses successfully!\n");

  });
});
