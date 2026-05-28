// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - training_coordinator_dashboard", () => {
  it("opens and verifies screen training_coordinator_dashboard", () => {
    cy.loginAsRole("training");

  cy.visitWithSemantics("/staff/training-coordinator-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("trainingcoordinatordashboard-screen").should("be.visible");
  cy.getCy("trainingcoordinatordashboard-title").should("be.visible");
  cy.getCy("trainingcoordinatordashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("training_coordinator_dashboard");

  });
});
