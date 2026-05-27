// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - outreach_campaign", () => {
  it("opens and verifies screen outreach_campaign", () => {
    cy.loginAsRole("bus_dev");

  cy.visit("/management/outreach-campaign");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("outreachcampaign-screen").should("be.visible");
  cy.getCy("outreachcampaign-title").should("be.visible");
  cy.getCy("outreachcampaign-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("outreach_campaign");

  });
});
