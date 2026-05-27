// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - campaign_dashboard", () => {
  it("opens and verifies screen campaign_dashboard", () => {
    cy.loginAsRole("marketing");

  cy.visit("/management/campaign-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("campaigndashboard-screen").should("be.visible");
  cy.getCy("campaigndashboard-title").should("be.visible");
  cy.getCy("campaigndashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("campaign_dashboard");

  });
});
