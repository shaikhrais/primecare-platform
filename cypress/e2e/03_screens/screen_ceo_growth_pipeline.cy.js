// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - ceo_growth_pipeline", () => {
  it("opens and verifies screen ceo_growth_pipeline", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/corporate/roles/ceo/growth-pipeline (Ceo Growth Pipeline)...");
  cy.visitWithSemantics("/offices/corporate/roles/ceo/growth-pipeline");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Ceo Growth Pipeline...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("ceogrowthpipeline-screen").should("be.visible");
  cy.getCy("ceogrowthpipeline-title").should("be.visible");
  cy.getCy("ceogrowthpipeline-content").should("be.visible");
  cy.getCy("growthpipeline-btn-reviewgoals").should("be.visible");
  cy.getCy("growthpipeline-btn-analyzetrends").should("be.visible");
  cy.getCy("growthpipeline-btn-implementchanges").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Ceo Growth Pipeline...");
  cy.waitAndSee();
  cy.screenshot("ceo_growth_pipeline");
  
  cy.task("log", "✅ PROGRESS: - Verified Ceo Growth Pipeline successfully!\n");

  });
});
