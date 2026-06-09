// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - cfo_invoices", () => {
  it("opens and verifies screen cfo_invoices", () => {
    cy.loginAsRole("cfo");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/corporate/roles/cfo/invoices (CfoInvoicesScreen)...");
  cy.visitWithSemantics("/offices/corporate/roles/cfo/invoices");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for CfoInvoicesScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("cfoinvoices-screen").should("be.visible");
  cy.getCy("cfoinvoices-title").should("be.visible");
  cy.getCy("cfoinvoices-content").should("be.visible");
  cy.getCy("cfo-dashboard-kpi").should("be.visible");
  cy.getCy("cfo-dashboard-cashflow").should("be.visible");
  cy.getCy("cfo-dashboard-budget").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for CfoInvoicesScreen...");
  cy.waitAndSee();
  cy.screenshot("cfo_invoices");
  
  cy.task("log", "✅ PROGRESS: - Verified CfoInvoicesScreen successfully!\n");

  });
});
