// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - intake_coordinator_follow_up", () => {
  it("opens and verifies screen intake_coordinator_follow_up", () => {
    cy.loginAsRole("volunteer_coordinator");

  cy.visit("/executive/intake-coordinator-follow-up");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("intakecoordinatorfollowup-screen").should("be.visible");
  cy.getCy("intakecoordinatorfollowup-title").should("be.visible");
  cy.getCy("intakecoordinatorfollowup-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("intake_coordinator_follow_up");

  });
});
