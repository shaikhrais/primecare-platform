// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - cfo_accounts_payable", () => {
  it("opens and verifies screen cfo_accounts_payable", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/corporate/roles/cfo/accounts-payable (Cfo Accounts Payable)...");
  cy.visitWithSemantics("/offices/corporate/roles/cfo/accounts-payable");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Cfo Accounts Payable...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("cfoaccountspayable-screen").should("be.visible");
  cy.getCy("cfoaccountspayable-title").should("be.visible");
  cy.getCy("cfoaccountspayable-content").should("be.visible");
  cy.getCy("cfo_accounts_payable-btn-approve-invoice").should("be.visible");
  cy.getCy("cfo_accounts_payable-btn-manage-payments").should("be.visible");
  cy.getCy("cfo_accounts_payable-btn-generate-report").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Cfo Accounts Payable...");
  cy.waitAndSee();
  cy.screenshot("cfo_accounts_payable");
  
  cy.task("log", "✅ PROGRESS: - Verified Cfo Accounts Payable successfully!\n");

  });
});
