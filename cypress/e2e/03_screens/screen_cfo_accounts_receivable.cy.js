// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - cfo_accounts_receivable", () => {
  it("opens and verifies screen cfo_accounts_receivable", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/corporate/roles/cfo/accounts-receivable (Cfo Accounts Receivable)...");
  cy.visitWithSemantics("/offices/corporate/roles/cfo/accounts-receivable");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Cfo Accounts Receivable...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("cfoaccountsreceivable-screen").should("be.visible");
  cy.getCy("cfoaccountsreceivable-title").should("be.visible");
  cy.getCy("cfoaccountsreceivable-content").should("be.visible");
  cy.getCy("cfo-accounts-receivable-overview").should("be.visible");
  cy.getCy("cfo-accounts-receivable-aging-report").should("be.visible");
  cy.getCy("cfo-accounts-receivable-overdue-alert").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Cfo Accounts Receivable...");
  cy.waitAndSee();
  cy.screenshot("cfo_accounts_receivable");
  
  cy.task("log", "✅ PROGRESS: - Verified Cfo Accounts Receivable successfully!\n");

  });
});
