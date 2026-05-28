// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - chiropractor_treatment_notes", () => {
  it("opens and verifies screen chiropractor_treatment_notes", () => {
    cy.loginAsRole("chiropractor");

  cy.visitWithSemantics("/allied/chiropractor-treatment-notes");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("chiropractortreatmentnotes-screen").should("be.visible");
  cy.getCy("chiropractortreatmentnotes-title").should("be.visible");
  cy.getCy("chiropractortreatmentnotes-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("chiropractor_treatment_notes");

  });
});
