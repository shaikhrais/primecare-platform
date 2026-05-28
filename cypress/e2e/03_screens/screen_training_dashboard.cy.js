// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - training_dashboard", () => {
  it("opens and verifies screen training_dashboard", () => {
    cy.loginAsRole("training_coordinator");

  cy.visitWithSemantics("/staff/training-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("trainingdashboard-screen").should("be.visible");
  cy.getCy("trainingdashboard-title").should("be.visible");
  cy.getCy("trainingdashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("training_dashboard");

  });
});
