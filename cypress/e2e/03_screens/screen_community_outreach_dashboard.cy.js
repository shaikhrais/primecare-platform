// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - community_outreach_dashboard", () => {
  it("opens and verifies screen community_outreach_dashboard", () => {
    cy.loginAsRole("community_outreach");

  cy.task("log", "⏳ PROGRESS: - Navigating to /management/community-outreach-dashboard (CommunityOutreachDashboardScreen)...");
  cy.visitWithSemantics("/management/community-outreach-dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for CommunityOutreachDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("communityoutreachdashboard-screen").should("be.visible");
  cy.getCy("communityoutreachdashboard-title").should("be.visible");
  cy.getCy("communityoutreachdashboard-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for CommunityOutreachDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("community_outreach_dashboard");
  
  cy.task("log", "✅ PROGRESS: - Verified CommunityOutreachDashboardScreen successfully!\n");

  });
});
