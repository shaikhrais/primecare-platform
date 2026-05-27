// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - community_outreach_workflow", () => {
  it("opens and verifies screen community_outreach_workflow", () => {
    cy.loginAsRole("community_outreach");

  cy.visit("/management/community-outreach-workflow");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("communityoutreachworkflow-screen").should("be.visible");
  cy.getCy("communityoutreachworkflow-title").should("be.visible");
  cy.getCy("communityoutreachworkflow-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("community_outreach_workflow");

  });
});
