// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - training_director_analytics", () => {
  it("opens and verifies screen training_director_analytics", () => {
    cy.loginAsRole("training");

  cy.visitWithSemantics("/executive/training-director-analytics");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("trainingdirectoranalytics-screen").should("be.visible");
  cy.getCy("trainingdirectoranalytics-title").should("be.visible");
  cy.getCy("trainingdirectoranalytics-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("training_director_analytics");

  });
});
