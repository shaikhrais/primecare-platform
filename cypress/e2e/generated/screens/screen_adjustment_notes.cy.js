// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - adjustment_notes", () => {
  it("opens and verifies screen adjustment_notes", () => {
    cy.loginAsRole("chiropractor");

  cy.visit("/allied/adjustment-notes");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("adjustmentnotes-screen").should("be.visible");
  cy.getCy("adjustmentnotes-title").should("be.visible");
  cy.getCy("adjustmentnotes-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("adjustment_notes");

  });
});
