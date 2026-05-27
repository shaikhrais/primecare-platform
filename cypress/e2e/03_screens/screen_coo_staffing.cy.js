// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - coo_staffing", () => {
  it("opens and verifies screen coo_staffing", () => {
    cy.loginAsRole("coo");

  cy.visit("/executive/coo-staffing");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("coostaffing-screen").should("be.visible");
  cy.getCy("coostaffing-title").should("be.visible");
  cy.getCy("coostaffing-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("coo_staffing");

  });
});
