// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - admin_payments", () => {
  it("opens and verifies screen admin_payments", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/franchise/roles/admin/payments (Admin Payments)...");
  cy.visitWithSemantics("/offices/franchise/roles/admin/payments");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Admin Payments...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("adminpayments-screen").should("be.visible");
  cy.getCy("adminpayments-title").should("be.visible");
  cy.getCy("adminpayments-content").should("be.visible");
  cy.getCy("admin-payments-btn-generate-report").should("be.visible");
  cy.getCy("admin-payments-btn-update-settings").should("be.visible");
  cy.getCy("admin-payments-btn-manage-disputes").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Admin Payments...");
  cy.waitAndSee();
  cy.screenshot("admin_payments");
  
  cy.task("log", "✅ PROGRESS: - Verified Admin Payments successfully!\n");

  });
});
