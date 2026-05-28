// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Role All Screens - premium_concierge", () => {
  it("tests all screens for role premium_concierge", () => {
    cy.loginAsRole("premium_concierge");


  cy.visitWithSemantics("/management/premium-concierge-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("premiumconciergedashboard-screen").should("be.visible");
  cy.getCy("premiumconciergedashboard-title").should("be.visible");
  cy.getCy("premiumconciergedashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("premium_concierge_dashboard");

  cy.visitWithSemantics("/premium/premium-concierge-analytics");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("premium concierge care coordinator analytics-screen").should("be.visible");
  cy.getCy("premium concierge care coordinator analytics-title").should("be.visible");
  cy.getCy("premium concierge care coordinator analytics-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("premium_concierge_analytics");

  cy.visitWithSemantics("/premium/premium-concierge-workflow");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("premium concierge care coordinator compliance workflow-screen").should("be.visible");
  cy.getCy("premium concierge care coordinator compliance workflow-title").should("be.visible");
  cy.getCy("premium concierge care coordinator compliance workflow-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("premium_concierge_workflow");

  });
});
