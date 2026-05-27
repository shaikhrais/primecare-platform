// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - training_director_compliance", () => {
  it("opens and verifies screen training_director_compliance", () => {
    cy.loginAsRole("training");

  cy.visit("/executive/training-director-compliance");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("trainingdirectorcompliance-screen").should("be.visible");
  cy.getCy("trainingdirectorcompliance-title").should("be.visible");
  cy.getCy("trainingdirectorcompliance-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("training_director_compliance");

  });
});
