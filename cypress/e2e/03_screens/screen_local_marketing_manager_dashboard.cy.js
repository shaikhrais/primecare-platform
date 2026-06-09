// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - local_marketing_manager_dashboard", () => {
  it("opens and verifies screen local_marketing_manager_dashboard", () => {
    cy.loginAsRole("local_marketing");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/marketing/roles/local_marketing_manager/dashboard (LocalMarketingManagerDashboardScreen)...");
  cy.visitWithSemantics("/offices/marketing/roles/local_marketing_manager/dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for LocalMarketingManagerDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("localmarketingmanagerdashboard-screen").should("be.visible");
  cy.getCy("localmarketingmanagerdashboard-title").should("be.visible");
  cy.getCy("localmarketingmanagerdashboard-content").should("be.visible");
  cy.getCy("localmarketing-dashboard-campaigns").should("be.visible");
  cy.getCy("localmarketing-dashboard-socialmedia").should("be.visible");
  cy.getCy("localmarketing-dashboard-feedback").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for LocalMarketingManagerDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("local_marketing_manager_dashboard");
  
  cy.task("log", "✅ PROGRESS: - Verified LocalMarketingManagerDashboardScreen successfully!\n");

  });
});
