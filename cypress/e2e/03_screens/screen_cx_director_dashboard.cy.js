// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - cx_director_dashboard", () => {
  it("opens and verifies screen cx_director_dashboard", () => {
    cy.loginAsRole("cx_director");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/corporate/roles/cx_director/dashboard (CxDirectorDashboardScreen)...");
  cy.visitWithSemantics("/offices/corporate/roles/cx_director/dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for CxDirectorDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("cxdirectordashboard-screen").should("be.visible");
  cy.getCy("cxdirectordashboard-title").should("be.visible");
  cy.getCy("cxdirectordashboard-content").should("be.visible");
  cy.getCy("cxdashboard-widget-customer-satisfaction").should("be.visible");
  cy.getCy("cxdashboard-widget-feedback-trends").should("be.visible");
  cy.getCy("cxdashboard-widget-kpi").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for CxDirectorDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("cx_director_dashboard");
  
  cy.task("log", "✅ PROGRESS: - Verified CxDirectorDashboardScreen successfully!\n");

  });
});
