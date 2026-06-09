// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - chiropractor_billing_link", () => {
  it("opens and verifies screen chiropractor_billing_link", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/clinical/roles/chiropractor/billing-link (ChiropractorBillingLinkScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/chiropractor/billing-link");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for ChiropractorBillingLinkScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("chiropractorbillinglink-screen").should("be.visible");
  cy.getCy("chiropractorbillinglink-title").should("be.visible");
  cy.getCy("chiropractorbillinglink-content").should("be.visible");
  cy.getCy("chiropractor-dashboard-btn-compliance-scan").should("be.visible");
  cy.getCy("chiropractor-dashboard-btn-operational-action").should("be.visible");
  cy.getCy("chiropractor-dashboard-btn-view-patient-records").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for ChiropractorBillingLinkScreen...");
  cy.waitAndSee();
  cy.screenshot("chiropractor_billing_link");
  
  cy.task("log", "✅ PROGRESS: - Verified ChiropractorBillingLinkScreen successfully!\n");

  });
});
