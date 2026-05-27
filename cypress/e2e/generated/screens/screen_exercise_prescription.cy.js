// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - exercise_prescription", () => {
  it("opens and verifies screen exercise_prescription", () => {
    cy.loginAsRole("physio");

  cy.visit("/clinical/exercise-prescription");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("exerciseprescription-screen").should("be.visible");
  cy.getCy("exerciseprescription-title").should("be.visible");
  cy.getCy("exerciseprescription-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("exercise_prescription");

  });
});
