// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - rmt_treatment_notes", () => {
  it("opens and verifies screen rmt_treatment_notes", () => {
    cy.loginAsRole("rmt");

  cy.visit("/allied/rmt-treatment-notes");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("rmttreatmentnotes-screen").should("be.visible");
  cy.getCy("rmttreatmentnotes-title").should("be.visible");
  cy.getCy("rmttreatmentnotes-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("rmt_treatment_notes");

  });
});
