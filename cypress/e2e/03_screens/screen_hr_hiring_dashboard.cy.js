// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - hr_hiring_dashboard", () => {
  it("opens and verifies screen hr_hiring_dashboard", () => {
    cy.loginAsRole("hr_hiring");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/franchise/roles/hr_hiring/dashboard (HrHiringDashboardScreen)...");
  cy.visitWithSemantics("/offices/franchise/roles/hr_hiring/dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for HrHiringDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("hrhiringdashboard-screen").should("be.visible");
  cy.getCy("hrhiringdashboard-title").should("be.visible");
  cy.getCy("hrhiringdashboard-content").should("be.visible");
  cy.getCy("hr_dashboard-kpi-widget").should("be.visible");
  cy.getCy("hr_dashboard-candidate-pipeline").should("be.visible");
  cy.getCy("hr_dashboard-source-analysis").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for HrHiringDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("hr_hiring_dashboard");
  
  cy.task("log", "✅ PROGRESS: - Verified HrHiringDashboardScreen successfully!\n");

  });
});
