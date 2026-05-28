// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - community_outreach_dashboard", () => {
  it("opens and verifies screen community_outreach_dashboard", () => {
    cy.loginAsRole("community_outreach");

  cy.visitWithSemantics("/management/community-outreach-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("communityoutreachdashboard-screen").should("be.visible");
  cy.getCy("communityoutreachdashboard-title").should("be.visible");
  cy.getCy("communityoutreachdashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("community_outreach_dashboard");

  });
});
