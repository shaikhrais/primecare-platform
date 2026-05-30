// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - billing_admin_workflow", () => {
  it("opens and verifies screen billing_admin_workflow", () => {
    cy.loginAsRole("admin");

  cy.task("log", "⏳ PROGRESS: - Navigating to /staff/billing-admin-workflow (BillingAdminWorkflowScreen)...");
  cy.visitWithSemantics("/staff/billing-admin-workflow");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for BillingAdminWorkflowScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("billingadminworkflow-screen").should("be.visible");
  cy.getCy("billingadminworkflow-title").should("be.visible");
  cy.getCy("billingadminworkflow-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for BillingAdminWorkflowScreen...");
  cy.waitAndSee();
  cy.screenshot("billing_admin_workflow");
  
  cy.task("log", "✅ PROGRESS: - Verified BillingAdminWorkflowScreen successfully!\n");

  });
});
