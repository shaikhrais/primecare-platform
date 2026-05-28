// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - training_management", () => {
  it("opens and verifies screen training_management", () => {
    cy.loginAsRole("hr_director");

  cy.visitWithSemantics("/management/training-management");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("trainingmanagement-screen").should("be.visible");
  cy.getCy("trainingmanagement-title").should("be.visible");
  cy.getCy("trainingmanagement-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("training_management");

  });
});
