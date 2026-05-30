// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - hiring_pipeline", () => {
  it("opens and verifies screen hiring_pipeline", () => {
    cy.loginAsRole("hr_director");

  cy.task("log", "⏳ PROGRESS: - Navigating to /management/hiring-pipeline (HiringPipelineScreen)...");
  cy.visitWithSemantics("/management/hiring-pipeline");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for HiringPipelineScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("hiringpipeline-screen").should("be.visible");
  cy.getCy("hiringpipeline-title").should("be.visible");
  cy.getCy("hiringpipeline-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for HiringPipelineScreen...");
  cy.waitAndSee();
  cy.screenshot("hiring_pipeline");
  
  cy.task("log", "✅ PROGRESS: - Verified HiringPipelineScreen successfully!\n");

  });
});
