// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - community_outreach_analytics", () => {
  it("opens and verifies screen community_outreach_analytics", () => {
    cy.loginAsRole("community_outreach");

  cy.visitWithSemantics("/management/community-outreach-analytics");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("communityoutreachanalytics-screen").should("be.visible");
  cy.getCy("communityoutreachanalytics-title").should("be.visible");
  cy.getCy("communityoutreachanalytics-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("community_outreach_analytics");

  });
});
