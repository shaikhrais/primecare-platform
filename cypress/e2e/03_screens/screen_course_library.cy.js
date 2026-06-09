// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - course_library", () => {
  it("opens and verifies screen course_library", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Course Library)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Course Library...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("courselibrary-screen").should("be.visible");
  cy.getCy("courselibrary-title").should("be.visible");
  cy.getCy("courselibrary-content").should("be.visible");
  cy.getCy("course-library-loading").should("be.visible");
  cy.getCy("course-library-error").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Course Library...");
  cy.waitAndSee();
  cy.screenshot("course_library");
  
  cy.task("log", "✅ PROGRESS: - Verified Course Library successfully!\n");

  });
});
