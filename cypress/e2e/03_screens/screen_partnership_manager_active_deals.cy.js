// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - partnership_manager_active_deals", () => {
  it("opens and verifies screen partnership_manager_active_deals", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/business_development/roles/partnership_manager/active-deals (Partnership Manager Active Deals)...");
  cy.visitWithSemantics("/offices/business_development/roles/partnership_manager/active-deals");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Partnership Manager Active Deals...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("partnershipmanageractivedeals-screen").should("be.visible");
  cy.getCy("partnershipmanageractivedeals-title").should("be.visible");
  cy.getCy("partnershipmanageractivedeals-content").should("be.visible");
  cy.getCy("partnerships-active-deals-overview").should("be.visible");
  cy.getCy("partnerships-performance-metrics").should("be.visible");
  cy.getCy("partnerships-red-flags-alerts").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Partnership Manager Active Deals...");
  cy.waitAndSee();
  cy.screenshot("partnership_manager_active_deals");
  
  cy.task("log", "✅ PROGRESS: - Verified Partnership Manager Active Deals successfully!\n");

  });
});
