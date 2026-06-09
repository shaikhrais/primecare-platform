// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - training_programs", () => {
  it("opens and verifies screen training_programs", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Training Programs)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Training Programs...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("trainingprograms-screen").should("be.visible");
  cy.getCy("trainingprograms-title").should("be.visible");
  cy.getCy("trainingprograms-content").should("be.visible");
  cy.getCy("loading-indicator").should("be.visible");
  cy.getCy("error-alert").should("be.visible");
  cy.getCy("training-program-list").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Training Programs...");
  cy.waitAndSee();
  cy.screenshot("training_programs");
  
  cy.task("log", "✅ PROGRESS: - Verified Training Programs successfully!\n");

  });
});
