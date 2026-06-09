// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - regional_manager_usa_dashboard", () => {
  it("opens and verifies screen regional_manager_usa_dashboard", () => {
    cy.loginAsRole("regional_manager_usa");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/business_development/roles/regional_manager_usa/dashboard (RegionalManagerUsaDashboardScreen)...");
  cy.visitWithSemantics("/offices/business_development/roles/regional_manager_usa/dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for RegionalManagerUsaDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("regionalmanagerusadashboard-screen").should("be.visible");
  cy.getCy("regionalmanagerusadashboard-title").should("be.visible");
  cy.getCy("regionalmanagerusadashboard-content").should("be.visible");
  cy.getCy("dashboard-btn-run-compliance-scan").should("be.visible");
  cy.getCy("dashboard-btn-export-audit-logs").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for RegionalManagerUsaDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("regional_manager_usa_dashboard");
  
  cy.task("log", "✅ PROGRESS: - Verified RegionalManagerUsaDashboardScreen successfully!\n");

  });
});
