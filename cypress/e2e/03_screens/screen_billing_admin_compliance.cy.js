// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - billing_admin_compliance", () => {
  it("opens and verifies screen billing_admin_compliance", () => {
    cy.loginAsRole("admin");

  cy.task("log", "⏳ PROGRESS: - Navigating to /staff/billing-admin-compliance (BillingAdminComplianceScreen)...");
  cy.visitWithSemantics("/staff/billing-admin-compliance");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for BillingAdminComplianceScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("billingadmincompliance-screen").should("be.visible");
  cy.getCy("billingadmincompliance-title").should("be.visible");
  cy.getCy("billingadmincompliance-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for BillingAdminComplianceScreen...");
  cy.waitAndSee();
  cy.screenshot("billing_admin_compliance");
  
  cy.task("log", "✅ PROGRESS: - Verified BillingAdminComplianceScreen successfully!\n");

  });
});
