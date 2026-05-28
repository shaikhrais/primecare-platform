// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - psw_my_shifts", () => {
  it("opens and verifies screen psw_my_shifts", () => {
    cy.loginAsRole("psw");

  cy.visitWithSemantics("/psw/psw-my-shifts");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("pswmyshifts-screen").should("be.visible");
  cy.getCy("pswmyshifts-title").should("be.visible");
  cy.getCy("pswmyshifts-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("psw_my_shifts");

  });
});
