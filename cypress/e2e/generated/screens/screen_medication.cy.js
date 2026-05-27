// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - medication", () => {
  it("opens and verifies screen medication", () => {
    cy.loginAsRole("rpn");

  cy.visit("/clinical/medication");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("medication-screen").should("be.visible");
  cy.getCy("medication-title").should("be.visible");
  cy.getCy("medication-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("medication");

  });
});
