// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - coo_staffing_efficiency", () => {
  it("opens and verifies screen coo_staffing_efficiency", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/corporate/roles/coo/staffing-efficiency (Coo Staffing Efficiency)...");
  cy.visitWithSemantics("/offices/corporate/roles/coo/staffing-efficiency");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Coo Staffing Efficiency...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("coostaffingefficiency-screen").should("be.visible");
  cy.getCy("coostaffingefficiency-title").should("be.visible");
  cy.getCy("coostaffingefficiency-content").should("be.visible");
  cy.getCy("staffing-metrics-card").should("be.visible");
  cy.getCy("trend-visualization-chart").should("be.visible");
  cy.getCy("alerts-notification-panel").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Coo Staffing Efficiency...");
  cy.waitAndSee();
  cy.screenshot("coo_staffing_efficiency");
  
  cy.task("log", "✅ PROGRESS: - Verified Coo Staffing Efficiency successfully!\n");

  });
});
