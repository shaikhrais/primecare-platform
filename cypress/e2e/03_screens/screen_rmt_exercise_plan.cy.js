// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - rmt_exercise_plan", () => {
  it("opens and verifies screen rmt_exercise_plan", () => {
    cy.loginAsRole("rmt");

  cy.visit("/allied/rmt-exercise-plan");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("rmtexerciseplan-screen").should("be.visible");
  cy.getCy("rmtexerciseplan-title").should("be.visible");
  cy.getCy("rmtexerciseplan-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("rmt_exercise_plan");

  });
});
