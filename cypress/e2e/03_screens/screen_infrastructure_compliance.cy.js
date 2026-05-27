// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - infrastructure_compliance", () => {
  it("opens and verifies screen infrastructure_compliance", () => {
    cy.loginAsRole("infrastructure");

  cy.visit("/common/infrastructure-compliance");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("infrastructurecompliance-screen").should("be.visible");
  cy.getCy("infrastructurecompliance-title").should("be.visible");
  cy.getCy("infrastructurecompliance-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("infrastructure_compliance");

  });
});
