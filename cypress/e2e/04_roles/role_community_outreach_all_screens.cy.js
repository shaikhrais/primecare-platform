// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Role All Screens - community_outreach", () => {
  it("tests all screens for role community_outreach", () => {
    cy.loginAsRole("community_outreach");


  cy.task("log", "⏳ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [1/1 | 100%] - Navigating to /offices/marketing/roles/community_outreach/dashboard (CommunityOutreachDashboardScreen)...");
  cy.visitWithSemantics("/offices/marketing/roles/community_outreach/dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [1/1 | 100%] - Checking shell & content for CommunityOutreachDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("communityoutreachdashboard-screen").should("be.visible");
  cy.getCy("communityoutreachdashboard-title").should("be.visible");
  cy.getCy("communityoutreachdashboard-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [1/1 | 100%] - Saving screenshot for CommunityOutreachDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("community_outreach_dashboard");
  
  cy.task("log", "✅ PROGRESS: 🟩🟩🟩🟩🟩🟩🟩🟩🟩🟩 [1/1 | 100%] - Verified CommunityOutreachDashboardScreen successfully!\n");

  });
});
