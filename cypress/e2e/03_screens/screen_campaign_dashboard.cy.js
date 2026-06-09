// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - campaign_dashboard", () => {
  it("opens and verifies screen campaign_dashboard", () => {
    cy.loginAsRole("marketing");

  cy.task("log", "⏳ PROGRESS: - Navigating to /management/campaign-dashboard (CampaignDashboardScreen)...");
  cy.visitWithSemantics("/management/campaign-dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for CampaignDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("campaigndashboard-screen").should("be.visible");
  cy.getCy("campaigndashboard-title").should("be.visible");
  cy.getCy("campaigndashboard-content").should("be.visible");
  cy.getCy("campaign-dashboard-refresh").should("be.visible");
  cy.getCy("campaign-dashboard-view-report").should("be.visible");
  cy.getCy("campaign-dashboard-export-metrics").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for CampaignDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("campaign_dashboard");
  
  cy.task("log", "✅ PROGRESS: - Verified CampaignDashboardScreen successfully!\n");

  });
});
