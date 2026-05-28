// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - cfo_dashboard", () => {
  it("opens and verifies screen cfo_dashboard", () => {
    cy.loginAsRole("cfo");

  cy.visitWithSemantics("/executive/cfo-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("cfodashboard-screen").should("be.visible");
  cy.getCy("cfodashboard-title").should("be.visible");
  cy.getCy("cfodashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("cfo_dashboard");

  });
});
