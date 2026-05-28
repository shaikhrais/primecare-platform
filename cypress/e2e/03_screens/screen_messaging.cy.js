// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - messaging", () => {
  it("opens and verifies screen messaging", () => {
    cy.loginAsRole("caregiver");

  cy.visitWithSemantics("/psw/messaging");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("messaging-screen").should("be.visible");
  cy.getCy("messaging-title").should("be.visible");
  cy.getCy("messaging-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("messaging");

  });
});
