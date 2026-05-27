// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - cto_compliance", () => {
  it("opens and verifies screen cto_compliance", () => {
    cy.loginAsRole("cto");

  cy.visit("/executive/cto-compliance");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("ctocompliance-screen").should("be.visible");
  cy.getCy("ctocompliance-title").should("be.visible");
  cy.getCy("ctocompliance-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("cto_compliance");

  });
});
