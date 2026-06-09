// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - ceo_revenue_summary", () => {
  it("opens and verifies screen ceo_revenue_summary", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/corporate/roles/ceo/revenue-summary (Ceo Revenue Summary)...");
  cy.visitWithSemantics("/offices/corporate/roles/ceo/revenue-summary");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Ceo Revenue Summary...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("ceorevenuesummary-screen").should("be.visible");
  cy.getCy("ceorevenuesummary-title").should("be.visible");
  cy.getCy("ceorevenuesummary-content").should("be.visible");
  cy.getCy("revenue-summary-card").should("be.visible");
  cy.getCy("revenue-trend-chart").should("be.visible");
  cy.getCy("kpi-indicator").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Ceo Revenue Summary...");
  cy.waitAndSee();
  cy.screenshot("ceo_revenue_summary");
  
  cy.task("log", "✅ PROGRESS: - Verified Ceo Revenue Summary successfully!\n");

  });
});
