// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - finance_director_cashflow", () => {
  it("opens and verifies screen finance_director_cashflow", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/corporate/roles/finance_director/cashflow (Finance Director Cashflow)...");
  cy.visitWithSemantics("/offices/corporate/roles/finance_director/cashflow");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Finance Director Cashflow...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("financedirectorcashflow-screen").should("be.visible");
  cy.getCy("financedirectorcashflow-title").should("be.visible");
  cy.getCy("financedirectorcashflow-content").should("be.visible");
  cy.getCy("cashflow-metrics").should("be.visible");
  cy.getCy("cashflow-alerts").should("be.visible");
  cy.getCy("cashflow-trends").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Finance Director Cashflow...");
  cy.waitAndSee();
  cy.screenshot("finance_director_cashflow");
  
  cy.task("log", "✅ PROGRESS: - Verified Finance Director Cashflow successfully!\n");

  });
});
