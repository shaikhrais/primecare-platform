// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - community_outreach_analytics", () => {
  it("opens and verifies screen community_outreach_analytics", () => {
    cy.loginAsRole("community_outreach");

  cy.task("log", "⏳ PROGRESS: - Navigating to /management/community-outreach-analytics (CommunityOutreachAnalyticsScreen)...");
  cy.visitWithSemantics("/management/community-outreach-analytics");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for CommunityOutreachAnalyticsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("communityoutreachanalytics-screen").should("be.visible");
  cy.getCy("communityoutreachanalytics-title").should("be.visible");
  cy.getCy("communityoutreachanalytics-content").should("be.visible");
  cy.getCy("communityoutreach-kpi-chart").should("be.visible");
  cy.getCy("communityoutreach-engagement-metrics").should("be.visible");
  cy.getCy("communityoutreach-budget-tracker").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for CommunityOutreachAnalyticsScreen...");
  cy.waitAndSee();
  cy.screenshot("community_outreach_analytics");
  
  cy.task("log", "✅ PROGRESS: - Verified CommunityOutreachAnalyticsScreen successfully!\n");

  });
});
