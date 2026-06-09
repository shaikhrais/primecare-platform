// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - billing_admin_analytics", () => {
  it("opens and verifies screen billing_admin_analytics", () => {
    cy.loginAsRole("admin");

  cy.task("log", "⏳ PROGRESS: - Navigating to /staff/billing-admin-analytics (BillingAdminAnalyticsScreen)...");
  cy.visitWithSemantics("/staff/billing-admin-analytics");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for BillingAdminAnalyticsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("billingadminanalytics-screen").should("be.visible");
  cy.getCy("billingadminanalytics-title").should("be.visible");
  cy.getCy("billingadminanalytics-content").should("be.visible");
  cy.getCy("billing_admin_btn_add_task").should("be.visible");
  cy.getCy("billing_admin_btn_schedule").should("be.visible");
  cy.getCy("billing_admin_btn_send_message").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for BillingAdminAnalyticsScreen...");
  cy.waitAndSee();
  cy.screenshot("billing_admin_analytics");
  
  cy.task("log", "✅ PROGRESS: - Verified BillingAdminAnalyticsScreen successfully!\n");

  });
});
