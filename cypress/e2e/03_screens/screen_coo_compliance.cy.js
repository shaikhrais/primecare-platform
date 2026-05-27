// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - coo_compliance", () => {
  it("opens and verifies screen coo_compliance", () => {
    cy.loginAsRole("coo");

  cy.visit("/executive/coo-compliance");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("coocompliance-screen").should("be.visible");
  cy.getCy("coocompliance-title").should("be.visible");
  cy.getCy("coocompliance-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("coo_compliance");

  });
});
