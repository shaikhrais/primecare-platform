// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - cfo_revenue", () => {
  it("opens and verifies screen cfo_revenue", () => {
    cy.loginAsRole("cfo");

  cy.visit("/executive/cfo-revenue");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("cforevenue-screen").should("be.visible");
  cy.getCy("cforevenue-title").should("be.visible");
  cy.getCy("cforevenue-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("cfo_revenue");

  });
});
