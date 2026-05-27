// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - service_quality", () => {
  it("opens and verifies screen service_quality", () => {
    cy.loginAsRole("coo");

  cy.visit("/executive/service-quality");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("servicequality-screen").should("be.visible");
  cy.getCy("servicequality-title").should("be.visible");
  cy.getCy("servicequality-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("service_quality");

  });
});
