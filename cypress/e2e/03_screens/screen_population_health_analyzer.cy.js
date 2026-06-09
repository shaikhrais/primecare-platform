// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - population_health_analyzer", () => {
  it("opens and verifies screen population_health_analyzer", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Population Health Analyzer)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Population Health Analyzer...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("populationhealthanalyzer-screen").should("be.visible");
  cy.getCy("populationhealthanalyzer-title").should("be.visible");
  cy.getCy("populationhealthanalyzer-content").should("be.visible");
  cy.getCy("populationhealth-btn-refresh").should("be.visible");
  cy.getCy("populationhealth-btn-export").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Population Health Analyzer...");
  cy.waitAndSee();
  cy.screenshot("population_health_analyzer");
  
  cy.task("log", "✅ PROGRESS: - Verified Population Health Analyzer successfully!\n");

  });
});
