// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - intake_coordinator_assessment_queue", () => {
  it("opens and verifies screen intake_coordinator_assessment_queue", () => {
    cy.loginAsRole("volunteer_coordinator");

  cy.visit("/executive/intake-coordinator-assessment-queue");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("intakecoordinatorassessmentqueue-screen").should("be.visible");
  cy.getCy("intakecoordinatorassessmentqueue-title").should("be.visible");
  cy.getCy("intakecoordinatorassessmentqueue-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("intake_coordinator_assessment_queue");

  });
});
