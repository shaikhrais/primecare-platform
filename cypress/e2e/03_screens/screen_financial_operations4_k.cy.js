// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - financial_operations4_k", () => {
  it("opens and verifies screen financial_operations4_k", () => {
    cy.loginAsRole("cfo");

  cy.task("log", "⏳ PROGRESS: - Navigating to /executive/financial-operations4-k (FinancialOperations4KScreen)...");
  cy.visitWithSemantics("/executive/financial-operations4-k");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for FinancialOperations4KScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("financialoperations4k-screen").should("be.visible");
  cy.getCy("financialoperations4k-title").should("be.visible");
  cy.getCy("financialoperations4k-content").should("be.visible");
  cy.getCy("cfo-dashboard-kpi").should("be.visible");
  cy.getCy("cfo-dashboard-financial-statements").should("be.visible");
  cy.getCy("cfo-dashboard-budget-comparison").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for FinancialOperations4KScreen...");
  cy.waitAndSee();
  cy.screenshot("financial_operations4_k");
  
  cy.task("log", "✅ PROGRESS: - Verified FinancialOperations4KScreen successfully!\n");

  });
});
