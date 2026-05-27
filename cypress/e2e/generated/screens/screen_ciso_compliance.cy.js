// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - ciso_compliance", () => {
  it("opens and verifies screen ciso_compliance", () => {
    cy.loginAsRole("ciso");

  cy.visit("/executive/ciso-compliance");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("cisocompliance-screen").should("be.visible");
  cy.getCy("cisocompliance-title").should("be.visible");
  cy.getCy("cisocompliance-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("ciso_compliance");

  });
});
