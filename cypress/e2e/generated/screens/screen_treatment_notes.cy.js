// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - treatment_notes", () => {
  it("opens and verifies screen treatment_notes", () => {
    cy.loginAsRole("rmt");

  cy.visit("/allied/treatment-notes");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("treatmentnotes-screen").should("be.visible");
  cy.getCy("treatmentnotes-title").should("be.visible");
  cy.getCy("treatmentnotes-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("treatment_notes");

  });
});
