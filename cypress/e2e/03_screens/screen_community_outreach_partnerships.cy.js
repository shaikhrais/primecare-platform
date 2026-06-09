// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - community_outreach_partnerships", () => {
  it("opens and verifies screen community_outreach_partnerships", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Community Outreach Partnerships)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Community Outreach Partnerships...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("communityoutreachpartnerships-screen").should("be.visible");
  cy.getCy("communityoutreachpartnerships-title").should("be.visible");
  cy.getCy("communityoutreachpartnerships-content").should("be.visible");
  cy.getCy("community-outreach-btn-update").should("be.visible");
  cy.getCy("community-outreach-btn-analyze").should("be.visible");
  cy.getCy("community-outreach-btn-engage").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Community Outreach Partnerships...");
  cy.waitAndSee();
  cy.screenshot("community_outreach_partnerships");
  
  cy.task("log", "✅ PROGRESS: - Verified Community Outreach Partnerships successfully!\n");

  });
});
