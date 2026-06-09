// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - regional_performance", () => {
  it("opens and verifies screen regional_performance", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to /generated/offices/corporate/roles/ceo/region-performance (Regional Performance)...");
  cy.visitWithSemantics("/generated/offices/corporate/roles/ceo/region-performance");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Regional Performance...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("regionalperformance-screen").should("be.visible");
  cy.getCy("regionalperformance-title").should("be.visible");
  cy.getCy("regionalperformance-content").should("be.visible");
  cy.getCy("regional-performance-metric-card").should("be.visible");
  cy.getCy("trend-analysis-chart").should("be.visible");
  cy.getCy("feedback-form").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Regional Performance...");
  cy.waitAndSee();
  cy.screenshot("regional_performance");
  
  cy.task("log", "✅ PROGRESS: - Verified Regional Performance successfully!\n");

  });
});
