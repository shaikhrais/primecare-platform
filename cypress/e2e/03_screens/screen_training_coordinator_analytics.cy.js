// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - training_coordinator_analytics", () => {
  it("opens and verifies screen training_coordinator_analytics", () => {
    cy.loginAsRole("training");

  cy.visitWithSemantics("/staff/training-coordinator-analytics");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("trainingcoordinatoranalytics-screen").should("be.visible");
  cy.getCy("trainingcoordinatoranalytics-title").should("be.visible");
  cy.getCy("trainingcoordinatoranalytics-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("training_coordinator_analytics");

  });
});
