// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - admin_outstanding_balances", () => {
  it("opens and verifies screen admin_outstanding_balances", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/franchise/roles/admin/outstanding-balances (Admin Outstanding Balances)...");
  cy.visitWithSemantics("/offices/franchise/roles/admin/outstanding-balances");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Admin Outstanding Balances...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("adminoutstandingbalances-screen").should("be.visible");
  cy.getCy("adminoutstandingbalances-title").should("be.visible");
  cy.getCy("adminoutstandingbalances-content").should("be.visible");
  cy.getCy("admin-outstanding-balances-overview").should("be.visible");
  cy.getCy("admin-balance-breakdown").should("be.visible");
  cy.getCy("admin-balance-alerts").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Admin Outstanding Balances...");
  cy.waitAndSee();
  cy.screenshot("admin_outstanding_balances");
  
  cy.task("log", "✅ PROGRESS: - Verified Admin Outstanding Balances successfully!\n");

  });
});
