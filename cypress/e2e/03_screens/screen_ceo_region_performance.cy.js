// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - ceo_region_performance", () => {
  it("opens and verifies screen ceo_region_performance", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/corporate/roles/ceo/region-performance (Ceo Region Performance)...");
  cy.visitWithSemantics("/offices/corporate/roles/ceo/region-performance");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Ceo Region Performance...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("ceoregionperformance-screen").should("be.visible");
  cy.getCy("ceoregionperformance-title").should("be.visible");
  cy.getCy("ceoregionperformance-content").should("be.visible");
  cy.getCy("ceo-region-performance-metric").should("be.visible");
  cy.getCy("ceo-region-alert-notification").should("be.visible");
  cy.getCy("ceo-region-report-generator").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Ceo Region Performance...");
  cy.waitAndSee();
  cy.screenshot("ceo_region_performance");
  
  cy.task("log", "✅ PROGRESS: - Verified Ceo Region Performance successfully!\n");

  });
});
