// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - chiropractor_exercise_plan", () => {
  it("opens and verifies screen chiropractor_exercise_plan", () => {
    cy.loginAsRole("chiropractor");

  cy.visitWithSemantics("/allied/chiropractor-exercise-plan");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("chiropractorexerciseplan-screen").should("be.visible");
  cy.getCy("chiropractorexerciseplan-title").should("be.visible");
  cy.getCy("chiropractorexerciseplan-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("chiropractor_exercise_plan");

  });
});
