// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - community_outreach_compliance", () => {
  it("opens and verifies screen community_outreach_compliance", () => {
    cy.loginAsRole("community_outreach");

  cy.task("log", "⏳ PROGRESS: - Navigating to /management/community-outreach-compliance (CommunityOutreachComplianceScreen)...");
  cy.visitWithSemantics("/management/community-outreach-compliance");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for CommunityOutreachComplianceScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("communityoutreachcompliance-screen").should("be.visible");
  cy.getCy("communityoutreachcompliance-title").should("be.visible");
  cy.getCy("communityoutreachcompliance-content").should("be.visible");
  cy.getCy("outreach-btn-add-event").should("be.visible");
  cy.getCy("outreach-btn-submit-feedback").should("be.visible");
  cy.getCy("outreach-btn-generate-report").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for CommunityOutreachComplianceScreen...");
  cy.waitAndSee();
  cy.screenshot("community_outreach_compliance");
  
  cy.task("log", "✅ PROGRESS: - Verified CommunityOutreachComplianceScreen successfully!\n");

  });
});
