// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - financial_dashboard", () => {
  it("opens and verifies screen financial_dashboard", () => {
    cy.loginAsRole("cfo");

  cy.task("log", "⏳ PROGRESS: - Navigating to /executive/financial-dashboard (FinancialDashboardScreen)...");
  cy.visitWithSemantics("/executive/financial-dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for FinancialDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("financialdashboard-screen").should("be.visible");
  cy.getCy("financialdashboard-title").should("be.visible");
  cy.getCy("financialdashboard-content").should("be.visible");
  cy.getCy("financial-dashboard-kpi-overview").should("be.visible");
  cy.getCy("financial-dashboard-revenue-expense-trend").should("be.visible");
  cy.getCy("financial-dashboard-cash-flow").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for FinancialDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("financial_dashboard");
  
  cy.task("log", "✅ PROGRESS: - Verified FinancialDashboardScreen successfully!\n");

  });
});
