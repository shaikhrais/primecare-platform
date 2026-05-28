// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - booking", () => {
  it("opens and verifies screen booking", () => {
    cy.loginAsRole("intake");

  cy.visitWithSemantics("/executive/booking");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("booking-screen").should("be.visible");
  cy.getCy("booking-title").should("be.visible");
  cy.getCy("booking-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("booking");

  });
});
