// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - training_director_dashboard", () => {
  it("opens and verifies screen training_director_dashboard", () => {
    cy.loginAsRole("training_director");

  cy.visit("/executive/training-director-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("trainingdirectordashboard-screen").should("be.visible");
  cy.getCy("trainingdirectordashboard-title").should("be.visible");
  cy.getCy("trainingdirectordashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("training_director_dashboard");

  });
});
