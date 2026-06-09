// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - community_outreach_contacts", () => {
  it("opens and verifies screen community_outreach_contacts", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Community Outreach Contacts)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Community Outreach Contacts...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("communityoutreachcontacts-screen").should("be.visible");
  cy.getCy("communityoutreachcontacts-title").should("be.visible");
  cy.getCy("communityoutreachcontacts-content").should("be.visible");
  cy.getCy("community-outreach-btn-update-contact").should("be.visible");
  cy.getCy("community-outreach-btn-view-report").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Community Outreach Contacts...");
  cy.waitAndSee();
  cy.screenshot("community_outreach_contacts");
  
  cy.task("log", "✅ PROGRESS: - Verified Community Outreach Contacts successfully!\n");

  });
});
