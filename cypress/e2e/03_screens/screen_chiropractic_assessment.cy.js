// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - chiropractic_assessment", () => {
  it("opens and verifies screen chiropractic_assessment", () => {
    cy.loginAsRole("chiropractor");

  cy.visit("/allied/chiropractic-assessment");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("chiropracticassessment-screen").should("be.visible");
  cy.getCy("chiropracticassessment-title").should("be.visible");
  cy.getCy("chiropracticassessment-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("chiropractic_assessment");

  });
});
