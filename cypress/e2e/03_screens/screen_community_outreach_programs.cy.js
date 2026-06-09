// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - community_outreach_programs", () => {
  it("opens and verifies screen community_outreach_programs", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Community Outreach Programs)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Community Outreach Programs...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("communityoutreachprograms-screen").should("be.visible");
  cy.getCy("communityoutreachprograms-title").should("be.visible");
  cy.getCy("communityoutreachprograms-content").should("be.visible");
  cy.getCy("community-outreach-loading").should("be.visible");
  cy.getCy("community-outreach-error-log").should("be.visible");
  cy.getCy("community-outreach-summary").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Community Outreach Programs...");
  cy.waitAndSee();
  cy.screenshot("community_outreach_programs");
  
  cy.task("log", "✅ PROGRESS: - Verified Community Outreach Programs successfully!\n");

  });
});
