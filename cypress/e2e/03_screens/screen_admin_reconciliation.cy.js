// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - admin_reconciliation", () => {
  it("opens and verifies screen admin_reconciliation", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/franchise/roles/admin/reconciliation (Admin Reconciliation)...");
  cy.visitWithSemantics("/offices/franchise/roles/admin/reconciliation");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Admin Reconciliation...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("adminreconciliation-screen").should("be.visible");
  cy.getCy("adminreconciliation-title").should("be.visible");
  cy.getCy("adminreconciliation-content").should("be.visible");
  cy.getCy("reconciliation-monitor").should("be.visible");
  cy.getCy("reconciliation-report-viewer").should("be.visible");
  cy.getCy("discrepancy-identifier").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Admin Reconciliation...");
  cy.waitAndSee();
  cy.screenshot("admin_reconciliation");
  
  cy.task("log", "✅ PROGRESS: - Verified Admin Reconciliation successfully!\n");

  });
});
