// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - billing_overview", () => {
  it("opens and verifies screen billing_overview", () => {
    cy.loginAsRole("family");

  cy.task("log", "⏳ PROGRESS: - Navigating to /common/billing-overview (BillingOverviewScreen)...");
  cy.visitWithSemantics("/common/billing-overview");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for BillingOverviewScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("billingoverview-screen").should("be.visible");
  cy.getCy("billingoverview-title").should("be.visible");
  cy.getCy("billingoverview-content").should("be.visible");
  cy.getCy("billing-overview-btn-execute-scan").should("be.visible");
  cy.getCy("billing-overview-btn-refresh").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for BillingOverviewScreen...");
  cy.waitAndSee();
  cy.screenshot("billing_overview");
  
  cy.task("log", "✅ PROGRESS: - Verified BillingOverviewScreen successfully!\n");

  });
});
