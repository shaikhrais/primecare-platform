// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - partnership_manager_renewals", () => {
  it("opens and verifies screen partnership_manager_renewals", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/business_development/roles/partnership_manager/renewals (Partnership Manager Renewals)...");
  cy.visitWithSemantics("/offices/business_development/roles/partnership_manager/renewals");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Partnership Manager Renewals...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("partnershipmanagerrenewals-screen").should("be.visible");
  cy.getCy("partnershipmanagerrenewals-title").should("be.visible");
  cy.getCy("partnershipmanagerrenewals-content").should("be.visible");
  cy.getCy("partnerships-renewal-overview").should("be.visible");
  cy.getCy("partnerships-overdue-alerts").should("be.visible");
  cy.getCy("partnerships-performance-metrics").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Partnership Manager Renewals...");
  cy.waitAndSee();
  cy.screenshot("partnership_manager_renewals");
  
  cy.task("log", "✅ PROGRESS: - Verified Partnership Manager Renewals successfully!\n");

  });
});
