// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - growth_pipeline", () => {
  it("opens and verifies screen growth_pipeline", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to /generated/offices/corporate/roles/ceo/growth-pipeline (Growth Pipeline)...");
  cy.visitWithSemantics("/generated/offices/corporate/roles/ceo/growth-pipeline");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Growth Pipeline...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("growthpipeline-screen").should("be.visible");
  cy.getCy("growthpipeline-title").should("be.visible");
  cy.getCy("growthpipeline-content").should("be.visible");
  cy.getCy("growthpipeline-btn-analyze").should("be.visible");
  cy.getCy("growthpipeline-btn-identify").should("be.visible");
  cy.getCy("growthpipeline-btn-collaborate").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Growth Pipeline...");
  cy.waitAndSee();
  cy.screenshot("growth_pipeline");
  
  cy.task("log", "✅ PROGRESS: - Verified Growth Pipeline successfully!\n");

  });
});
