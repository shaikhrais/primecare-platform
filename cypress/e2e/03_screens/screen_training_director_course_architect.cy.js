// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - training_director_course_architect", () => {
  it("opens and verifies screen training_director_course_architect", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/corporate/roles/training_director/course-architect (Training Director Course Architect)...");
  cy.visitWithSemantics("/offices/corporate/roles/training_director/course-architect");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Training Director Course Architect...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("trainingdirectorcoursearchitect-screen").should("be.visible");
  cy.getCy("trainingdirectorcoursearchitect-title").should("be.visible");
  cy.getCy("content-display").should("be.visible");
  cy.getCy("loading-indicator").should("be.visible");
  cy.getCy("error-message").should("be.visible");
  cy.getCy("status-indicator").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Training Director Course Architect...");
  cy.waitAndSee();
  cy.screenshot("training_director_course_architect");
  
  cy.task("log", "✅ PROGRESS: - Verified Training Director Course Architect successfully!\n");

  });
});
