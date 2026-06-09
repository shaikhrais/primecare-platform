// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - partnership_manager_dashboard", () => {
  it("opens and verifies screen partnership_manager_dashboard", () => {
    cy.loginAsRole("partnership");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/business_development/roles/partnership_manager/dashboard (PartnershipManagerDashboardScreen)...");
  cy.visitWithSemantics("/offices/business_development/roles/partnership_manager/dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for PartnershipManagerDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("partnershipmanagerdashboard-screen").should("be.visible");
  cy.getCy("partnershipmanagerdashboard-title").should("be.visible");
  cy.getCy("partnershipmanagerdashboard-content").should("be.visible");
  cy.getCy("partnership-dashboard-btn-export-logs").should("be.visible");
  cy.getCy("partnership-dashboard-btn-refresh-data").should("be.visible");
  cy.getCy("partnership-dashboard-btn-view-audit").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for PartnershipManagerDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("partnership_manager_dashboard");
  
  cy.task("log", "✅ PROGRESS: - Verified PartnershipManagerDashboardScreen successfully!\n");

  });
});
