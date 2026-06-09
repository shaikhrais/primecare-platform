// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - franchise_dashboard", () => {
  it("opens and verifies screen franchise_dashboard", () => {
    cy.loginAsRole("owner");

  cy.task("log", "⏳ PROGRESS: - Navigating to /common/franchise-dashboard (FranchiseDashboardScreen)...");
  cy.visitWithSemantics("/common/franchise-dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for FranchiseDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("franchisedashboard-screen").should("be.visible");
  cy.getCy("franchisedashboard-title").should("be.visible");
  cy.getCy("franchisedashboard-content").should("be.visible");
  cy.getCy("franchise-dashboard-btn-export-logs").should("be.visible");
  cy.getCy("franchise-dashboard-btn-review-audit").should("be.visible");
  cy.getCy("franchise-dashboard-btn-update-policies").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for FranchiseDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("franchise_dashboard");
  
  cy.task("log", "✅ PROGRESS: - Verified FranchiseDashboardScreen successfully!\n");

  });
});
