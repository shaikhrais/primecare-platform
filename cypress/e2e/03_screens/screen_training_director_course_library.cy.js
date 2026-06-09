// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - training_director_course_library", () => {
  it("opens and verifies screen training_director_course_library", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/corporate/roles/training_director/course-library (Training Director Course Library)...");
  cy.visitWithSemantics("/offices/corporate/roles/training_director/course-library");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Training Director Course Library...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("trainingdirectorcourselibrary-screen").should("be.visible");
  cy.getCy("trainingdirectorcourselibrary-title").should("be.visible");
  cy.getCy("trainingdirectorcourselibrary-content").should("be.visible");
  cy.getCy("training-library-loading").should("be.visible");
  cy.getCy("training-library-error").should("be.visible");
  cy.getCy("training-library-refresh").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Training Director Course Library...");
  cy.waitAndSee();
  cy.screenshot("training_director_course_library");
  
  cy.task("log", "✅ PROGRESS: - Verified Training Director Course Library successfully!\n");

  });
});
