// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - premium_concierge_analytics", () => {
  it("opens and verifies screen premium_concierge_analytics", () => {
    cy.loginAsRole("premium_concierge");

  cy.visitWithSemantics("/premium/premium-concierge-analytics");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("premium concierge care coordinator analytics-screen").should("be.visible");
  cy.getCy("premium concierge care coordinator analytics-title").should("be.visible");
  cy.getCy("premium concierge care coordinator analytics-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("premium_concierge_analytics");

  });
});
