// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - community_outreach_follow_ups", () => {
  it("opens and verifies screen community_outreach_follow_ups", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Community Outreach Follow Ups)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Community Outreach Follow Ups...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("communityoutreachfollowups-screen").should("be.visible");
  cy.getCy("communityoutreachfollowups-title").should("be.visible");
  cy.getCy("communityoutreachfollowups-content").should("be.visible");
  cy.getCy("community-outreach-followups").should("be.visible");
  cy.getCy("community-outreach-status").should("be.visible");
  cy.getCy("community-feedback-analysis").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Community Outreach Follow Ups...");
  cy.waitAndSee();
  cy.screenshot("community_outreach_follow_ups");
  
  cy.task("log", "✅ PROGRESS: - Verified Community Outreach Follow Ups successfully!\n");

  });
});
