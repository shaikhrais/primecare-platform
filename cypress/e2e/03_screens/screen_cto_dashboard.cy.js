// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - cto_dashboard", () => {
  it("opens and verifies screen cto_dashboard", () => {
    cy.loginAsRole("cto");

  cy.visitWithSemantics("/executive/cto-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("ctodashboard-screen").should("be.visible");
  cy.getCy("ctodashboard-title").should("be.visible");
  cy.getCy("ctodashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("cto_dashboard");

  });
});
