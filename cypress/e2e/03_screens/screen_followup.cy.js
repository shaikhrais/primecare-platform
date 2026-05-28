// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - followup", () => {
  it("opens and verifies screen followup", () => {
    cy.loginAsRole("intake");

  cy.visitWithSemantics("/executive/followup");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("followup-screen").should("be.visible");
  cy.getCy("followup-title").should("be.visible");
  cy.getCy("followup-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("followup");

  });
});
