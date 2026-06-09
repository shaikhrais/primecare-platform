// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - course_architect", () => {
  it("opens and verifies screen course_architect", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Course Architect)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Course Architect...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("coursearchitect-screen").should("be.visible");
  cy.getCy("coursearchitect-title").should("be.visible");
  cy.getCy("coursearchitect-content").should("be.visible");
  cy.getCy("course-architect-loading").should("be.visible");
  cy.getCy("course-architect-error").should("be.visible");
  cy.getCy("course-architect-feature-status").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Course Architect...");
  cy.waitAndSee();
  cy.screenshot("course_architect");
  
  cy.task("log", "✅ PROGRESS: - Verified Course Architect successfully!\n");

  });
});
