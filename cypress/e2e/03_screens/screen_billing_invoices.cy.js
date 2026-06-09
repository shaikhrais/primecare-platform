// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - billing_invoices", () => {
  it("opens and verifies screen billing_invoices", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Billing Invoices)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Billing Invoices...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("billinginvoices-screen").should("be.visible");
  cy.getCy("billinginvoices-title").should("be.visible");
  cy.getCy("billinginvoices-content").should("be.visible");
  cy.getCy("billing-invoices-status").should("be.visible");
  cy.getCy("billing-audit-alert").should("be.visible");
  cy.getCy("billing-transaction-flow").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Billing Invoices...");
  cy.waitAndSee();
  cy.screenshot("billing_invoices");
  
  cy.task("log", "✅ PROGRESS: - Verified Billing Invoices successfully!\n");

  });
});
