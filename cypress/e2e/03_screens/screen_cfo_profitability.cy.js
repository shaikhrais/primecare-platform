// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - cfo_profitability", () => {
  it("opens and verifies screen cfo_profitability", () => {
    cy.loginAsRole("cfo");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/corporate/roles/cfo/profitability (CfoProfitabilityScreen)...");
  cy.visitWithSemantics("/offices/corporate/roles/cfo/profitability");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for CfoProfitabilityScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("cfoprofitability-screen").should("be.visible");
  cy.getCy("cfoprofitability-title").should("be.visible");
  cy.getCy("cfoprofitability-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for CfoProfitabilityScreen...");
  cy.waitAndSee();
  cy.screenshot("cfo_profitability");
  
  cy.task("log", "✅ PROGRESS: - Verified CfoProfitabilityScreen successfully!\n");

  });
});
