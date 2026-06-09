// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - ceo_strategic_kpis", () => {
  it("opens and verifies screen ceo_strategic_kpis", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/corporate/roles/ceo/strategic-kpis (Ceo Strategic Kpis)...");
  cy.visitWithSemantics("/offices/corporate/roles/ceo/strategic-kpis");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Ceo Strategic Kpis...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("ceostrategickpis-screen").should("be.visible");
  cy.getCy("ceostrategickpis-title").should("be.visible");
  cy.getCy("ceostrategickpis-content").should("be.visible");
  cy.getCy("kpi-display").should("be.visible");
  cy.getCy("trend-analysis-chart").should("be.visible");
  cy.getCy("alert-notification").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Ceo Strategic Kpis...");
  cy.waitAndSee();
  cy.screenshot("ceo_strategic_kpis");
  
  cy.task("log", "✅ PROGRESS: - Verified Ceo Strategic Kpis successfully!\n");

  });
});
