// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - rmt_billing_link", () => {
  it("opens and verifies screen rmt_billing_link", () => {
    cy.loginAsRole("rmt");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/clinical/roles/rmt/billing-link (RmtBillingLinkScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/rmt/billing-link");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for RmtBillingLinkScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("rmtbillinglink-screen").should("be.visible");
  cy.getCy("rmtbillinglink-title").should("be.visible");
  cy.getCy("rmtbillinglink-content").should("be.visible");
  cy.getCy("rmt-dashboard-btn-add-client").should("be.visible");
  cy.getCy("rmt-dashboard-btn-update-treatment").should("be.visible");
  cy.getCy("rmt-dashboard-btn-submit-billing").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for RmtBillingLinkScreen...");
  cy.waitAndSee();
  cy.screenshot("rmt_billing_link");
  
  cy.task("log", "✅ PROGRESS: - Verified RmtBillingLinkScreen successfully!\n");

  });
});
