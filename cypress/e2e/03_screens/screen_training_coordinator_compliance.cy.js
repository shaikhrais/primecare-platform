// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - training_coordinator_compliance", () => {
  it("opens and verifies screen training_coordinator_compliance", () => {
    cy.loginAsRole("training");

  cy.visit("/staff/training-coordinator-compliance");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("trainingcoordinatorcompliance-screen").should("be.visible");
  cy.getCy("trainingcoordinatorcompliance-title").should("be.visible");
  cy.getCy("trainingcoordinatorcompliance-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("training_coordinator_compliance");

  });
});
