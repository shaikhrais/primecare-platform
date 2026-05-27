// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - api_monitoring", () => {
  it("opens and verifies screen api_monitoring", () => {
    cy.loginAsRole("cto");

  cy.visit("/executive/api-monitoring");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("apimonitoring-screen").should("be.visible");
  cy.getCy("apimonitoring-title").should("be.visible");
  cy.getCy("apimonitoring-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("api_monitoring");

  });
});
