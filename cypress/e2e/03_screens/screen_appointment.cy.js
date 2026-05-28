// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - appointment", () => {
  it("opens and verifies screen appointment", () => {
    cy.loginAsRole("patient");

  cy.visitWithSemantics("/common/appointment");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("appointment-screen").should("be.visible");
  cy.getCy("appointment-title").should("be.visible");
  cy.getCy("appointment-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("appointment");

  });
});
