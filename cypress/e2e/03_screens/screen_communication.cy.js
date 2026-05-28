// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - communication", () => {
  it("opens and verifies screen communication", () => {
    cy.loginAsRole("customer_support");

  cy.visitWithSemantics("/staff/communication");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("communication-screen").should("be.visible");
  cy.getCy("communication-title").should("be.visible");
  cy.getCy("communication-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("communication");

  });
});
