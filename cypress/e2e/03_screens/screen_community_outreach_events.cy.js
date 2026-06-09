// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - community_outreach_events", () => {
  it("opens and verifies screen community_outreach_events", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Community Outreach Events)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Community Outreach Events...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("communityoutreachevents-screen").should("be.visible");
  cy.getCy("communityoutreachevents-title").should("be.visible");
  cy.getCy("communityoutreachevents-content").should("be.visible");
  cy.getCy("community-outreach-btn-update-event").should("be.visible");
  cy.getCy("community-outreach-btn-schedule-event").should("be.visible");
  cy.getCy("community-outreach-btn-view-feedback").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Community Outreach Events...");
  cy.waitAndSee();
  cy.screenshot("community_outreach_events");
  
  cy.task("log", "✅ PROGRESS: - Verified Community Outreach Events successfully!\n");

  });
});
