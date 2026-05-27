// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - cfo_tax", () => {
  it("opens and verifies screen cfo_tax", () => {
    cy.loginAsRole("cfo");

  cy.visit("/executive/cfo-tax");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("cfotax-screen").should("be.visible");
  cy.getCy("cfotax-title").should("be.visible");
  cy.getCy("cfotax-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("cfo_tax");

  });
});
