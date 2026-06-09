// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - community_outreach_volunteers", () => {
  it("opens and verifies screen community_outreach_volunteers", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Community Outreach Volunteers)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Community Outreach Volunteers...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("communityoutreachvolunteers-screen").should("be.visible");
  cy.getCy("communityoutreachvolunteers-title").should("be.visible");
  cy.getCy("communityoutreachvolunteers-content").should("be.visible");
  cy.getCy("volunteer-stats-card").should("be.visible");
  cy.getCy("events-calendar").should("be.visible");
  cy.getCy("feedback-summary").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Community Outreach Volunteers...");
  cy.waitAndSee();
  cy.screenshot("community_outreach_volunteers");
  
  cy.task("log", "✅ PROGRESS: - Verified Community Outreach Volunteers successfully!\n");

  });
});
