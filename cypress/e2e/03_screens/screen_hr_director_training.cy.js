// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - hr_director_training", () => {
  it("opens and verifies screen hr_director_training", () => {
    cy.loginAsRole("hr_director");

  cy.visitWithSemantics("/executive/hr-director-training");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("hrdirectortraining-screen").should("be.visible");
  cy.getCy("hrdirectortraining-title").should("be.visible");
  cy.getCy("hrdirectortraining-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("hr_director_training");

  });
});
