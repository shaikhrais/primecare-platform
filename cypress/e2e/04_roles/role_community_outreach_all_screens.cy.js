// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Role All Screens - community_outreach", () => {
  it("tests all screens for role community_outreach", () => {
    cy.loginAsRole("community_outreach");


  cy.visit("/management/community-outreach-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("communityoutreachdashboard-screen").should("be.visible");
  cy.getCy("communityoutreachdashboard-title").should("be.visible");
  cy.getCy("communityoutreachdashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("community_outreach_dashboard");

  cy.visit("/management/community-outreach-analytics");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("communityoutreachanalytics-screen").should("be.visible");
  cy.getCy("communityoutreachanalytics-title").should("be.visible");
  cy.getCy("communityoutreachanalytics-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("community_outreach_analytics");

  cy.visit("/management/community-outreach-compliance");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("communityoutreachcompliance-screen").should("be.visible");
  cy.getCy("communityoutreachcompliance-title").should("be.visible");
  cy.getCy("communityoutreachcompliance-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("community_outreach_compliance");

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
