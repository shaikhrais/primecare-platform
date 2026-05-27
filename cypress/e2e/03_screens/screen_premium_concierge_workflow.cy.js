// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - premium_concierge_workflow", () => {
  it("opens and verifies screen premium_concierge_workflow", () => {
    cy.loginAsRole("premium_concierge");

  cy.visit("/premium/premium-concierge-workflow");
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
