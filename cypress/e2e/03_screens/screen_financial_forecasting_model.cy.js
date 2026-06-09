// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - financial_forecasting_model", () => {
  it("opens and verifies screen financial_forecasting_model", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Financial Forecasting Model)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Financial Forecasting Model...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("financialforecastingmodel-screen").should("be.visible");
  cy.getCy("financialforecastingmodel-title").should("be.visible");
  cy.getCy("financialforecastingmodel-content").should("be.visible");
  cy.getCy("financial-forecast-btn-refresh").should("be.visible");
  cy.getCy("financial-forecast-btn-adjust").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Financial Forecasting Model...");
  cy.waitAndSee();
  cy.screenshot("financial_forecasting_model");
  
  cy.task("log", "✅ PROGRESS: - Verified Financial Forecasting Model successfully!\n");

  });
});
