// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - physiotherapist_billing_link", () => {
  it("opens and verifies screen physiotherapist_billing_link", () => {
    cy.loginAsRole("physio");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/clinical/roles/physiotherapist/billing-link (PhysiotherapistBillingLinkScreen)...");
  cy.visitWithSemantics("/offices/clinical/roles/physiotherapist/billing-link");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for PhysiotherapistBillingLinkScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("physiotherapistbillinglink-screen").should("be.visible");
  cy.getCy("physiotherapistbillinglink-title").should("be.visible");
  cy.getCy("physiotherapistbillinglink-content").should("be.visible");
  cy.getCy("physio-dashboard-btn-update-treatment").should("be.visible");
  cy.getCy("physio-dashboard-btn-log-progress").should("be.visible");
  cy.getCy("physio-dashboard-btn-view-compliance").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for PhysiotherapistBillingLinkScreen...");
  cy.waitAndSee();
  cy.screenshot("physiotherapist_billing_link");
  
  cy.task("log", "✅ PROGRESS: - Verified PhysiotherapistBillingLinkScreen successfully!\n");

  });
});
