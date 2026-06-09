// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - billing_admin_invoices", () => {
  it("opens and verifies screen billing_admin_invoices", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/franchise/roles/billing_admin/invoices (Billing Admin Invoices)...");
  cy.visitWithSemantics("/offices/franchise/roles/billing_admin/invoices");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Billing Admin Invoices...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("billingadmininvoices-screen").should("be.visible");
  cy.getCy("billingadmininvoices-title").should("be.visible");
  cy.getCy("billingadmininvoices-content").should("be.visible");
  cy.getCy("billing-admin-invoices").should("be.visible");
  cy.getCy("billing-invoice-review").should("be.visible");
  cy.getCy("billing-generate-report").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Billing Admin Invoices...");
  cy.waitAndSee();
  cy.screenshot("billing_admin_invoices");
  
  cy.task("log", "✅ PROGRESS: - Verified Billing Admin Invoices successfully!\n");

  });
});
