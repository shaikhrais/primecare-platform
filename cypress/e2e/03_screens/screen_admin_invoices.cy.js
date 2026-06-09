// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - admin_invoices", () => {
  it("opens and verifies screen admin_invoices", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/franchise/roles/admin/invoices (Admin Invoices)...");
  cy.visitWithSemantics("/offices/franchise/roles/admin/invoices");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Admin Invoices...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("admininvoices-screen").should("be.visible");
  cy.getCy("admininvoices-title").should("be.visible");
  cy.getCy("admininvoices-content").should("be.visible");
  cy.getCy("invoice-status-overview").should("be.visible");
  cy.getCy("btn-approve").should("be.visible");
  cy.getCy("btn-reject").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Admin Invoices...");
  cy.waitAndSee();
  cy.screenshot("admin_invoices");
  
  cy.task("log", "✅ PROGRESS: - Verified Admin Invoices successfully!\n");

  });
});
