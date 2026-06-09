// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - territory_expansion_manager_forecast", () => {
  it("opens and verifies screen territory_expansion_manager_forecast", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/business_development/roles/territory_expansion_manager/forecast (Territory Expansion Manager Forecast)...");
  cy.visitWithSemantics("/offices/business_development/roles/territory_expansion_manager/forecast");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Territory Expansion Manager Forecast...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("territoryexpansionmanagerforecast-screen").should("be.visible");
  cy.getCy("territoryexpansionmanagerforecast-title").should("be.visible");
  cy.getCy("territoryexpansionmanagerforecast-content").should("be.visible");
  cy.getCy("territory-expansion-forecast-chart").should("be.visible");
  cy.getCy("data-trend-analyzer").should("be.visible");
  cy.getCy("expansion-area-identifier").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Territory Expansion Manager Forecast...");
  cy.waitAndSee();
  cy.screenshot("territory_expansion_manager_forecast");
  
  cy.task("log", "✅ PROGRESS: - Verified Territory Expansion Manager Forecast successfully!\n");

  });
});
