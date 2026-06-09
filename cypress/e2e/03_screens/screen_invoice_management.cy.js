// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - invoice_management", () => {
  it("opens and verifies screen invoice_management", () => {
    cy.loginAsRole("admin");

  cy.task("log", "⏳ PROGRESS: - Navigating to /staff/invoice-management (InvoiceManagementScreen)...");
  cy.visitWithSemantics("/staff/invoice-management");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for InvoiceManagementScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("invoicemanagement-screen").should("be.visible");
  cy.getCy("invoicemanagement-title").should("be.visible");
  cy.getCy("invoicemanagement-content").should("be.visible");
  cy.getCy("invoice_management-btn-add-task").should("be.visible");
  cy.getCy("invoice_management-btn-schedule-appointment").should("be.visible");
  cy.getCy("invoice_management-btn-upload-document").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for InvoiceManagementScreen...");
  cy.waitAndSee();
  cy.screenshot("invoice_management");
  
  cy.task("log", "✅ PROGRESS: - Verified InvoiceManagementScreen successfully!\n");

  });
});
