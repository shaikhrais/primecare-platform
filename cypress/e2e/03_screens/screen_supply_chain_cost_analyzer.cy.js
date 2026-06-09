// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - supply_chain_cost_analyzer", () => {
  it("opens and verifies screen supply_chain_cost_analyzer", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Supply Chain Cost Analyzer)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Supply Chain Cost Analyzer...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("supplychaincostanalyzer-screen").should("be.visible");
  cy.getCy("supplychaincostanalyzer-title").should("be.visible");
  cy.getCy("supplychaincostanalyzer-content").should("be.visible");
  cy.getCy("supplychain-btn-refresh").should("be.visible");
  cy.getCy("supplychain-btn-manage-vendors").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Supply Chain Cost Analyzer...");
  cy.waitAndSee();
  cy.screenshot("supply_chain_cost_analyzer");
  
  cy.task("log", "✅ PROGRESS: - Verified Supply Chain Cost Analyzer successfully!\n");

  });
});
