// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - psw_compliance", () => {
  it("opens and verifies screen psw_compliance", () => {
    cy.loginAsRole("psw");

  cy.visit("/psw/psw-compliance");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("pswcompliance-screen").should("be.visible");
  cy.getCy("pswcompliance-title").should("be.visible");
  cy.getCy("pswcompliance-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("psw_compliance");

  });
});
