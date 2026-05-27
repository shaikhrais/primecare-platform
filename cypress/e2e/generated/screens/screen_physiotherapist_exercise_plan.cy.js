// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - physiotherapist_exercise_plan", () => {
  it("opens and verifies screen physiotherapist_exercise_plan", () => {
    cy.loginAsRole("physio");

  cy.visit("/allied/physiotherapist-exercise-plan");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("physiotherapistexerciseplan-screen").should("be.visible");
  cy.getCy("physiotherapistexerciseplan-title").should("be.visible");
  cy.getCy("physiotherapistexerciseplan-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("physiotherapist_exercise_plan");

  });
});
