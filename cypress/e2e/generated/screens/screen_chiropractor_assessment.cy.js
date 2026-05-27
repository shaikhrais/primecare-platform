// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - chiropractor_assessment", () => {
  it("opens and verifies screen chiropractor_assessment", () => {
    cy.loginAsRole("chiropractor");

  cy.visit("/allied/chiropractor-assessment");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("chiropractorassessment-screen").should("be.visible");
  cy.getCy("chiropractorassessment-title").should("be.visible");
  cy.getCy("chiropractorassessment-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("chiropractor_assessment");

  });
});
