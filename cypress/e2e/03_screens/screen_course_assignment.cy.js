// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - course_assignment", () => {
  it("opens and verifies screen course_assignment", () => {
    cy.loginAsRole("training_coordinator");

  cy.visitWithSemantics("/staff/course-assignment");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("courseassignment-screen").should("be.visible");
  cy.getCy("courseassignment-title").should("be.visible");
  cy.getCy("courseassignment-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("course_assignment");

  });
});
