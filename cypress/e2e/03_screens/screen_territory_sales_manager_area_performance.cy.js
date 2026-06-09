// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - territory_sales_manager_area_performance", () => {
  it("opens and verifies screen territory_sales_manager_area_performance", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Territory Sales Manager Area Performance)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Territory Sales Manager Area Performance...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("territorysalesmanagerareaperformance-screen").should("be.visible");
  cy.getCy("territorysalesmanagerareaperformance-title").should("be.visible");
  cy.getCy("territorysalesmanagerareaperformance-content").should("be.visible");
  cy.getCy("dashboard-sales-metrics").should("be.visible");
  cy.getCy("dashboard-sales-trends").should("be.visible");
  cy.getCy("dashboard-anomaly-alerts").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Territory Sales Manager Area Performance...");
  cy.waitAndSee();
  cy.screenshot("territory_sales_manager_area_performance");
  
  cy.task("log", "✅ PROGRESS: - Verified Territory Sales Manager Area Performance successfully!\n");

  });
});
