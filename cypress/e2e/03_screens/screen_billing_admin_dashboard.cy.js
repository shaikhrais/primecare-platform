// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - billing_admin_dashboard", () => {
  it("opens and verifies screen billing_admin_dashboard", () => {
    cy.loginAsRole("admin");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/franchise/roles/billing_admin/dashboard (BillingAdminDashboardScreen)...");
  cy.visitWithSemantics("/offices/franchise/roles/billing_admin/dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for BillingAdminDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("billingadmindashboard-screen").should("be.visible");
  cy.getCy("billingadmindashboard-title").should("be.visible");
  cy.getCy("billingadmindashboard-content").should("be.visible");
  cy.getCy("billing-dashboard-status-overview").should("be.visible");
  cy.getCy("billing-dashboard-discrepancy-metrics").should("be.visible");
  cy.getCy("billing-dashboard-activity-log").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for BillingAdminDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("billing_admin_dashboard");
  
  cy.task("log", "✅ PROGRESS: - Verified BillingAdminDashboardScreen successfully!\n");

  });
});
