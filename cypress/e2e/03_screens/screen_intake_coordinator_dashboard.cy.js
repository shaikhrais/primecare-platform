// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - intake_coordinator_dashboard", () => {
  it("opens and verifies screen intake_coordinator_dashboard", () => {
    cy.loginAsRole("intake");

  cy.visit("/staff/intake-coordinator-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("intakecoordinatordashboard-screen").should("be.visible");
  cy.getCy("intakecoordinatordashboard-title").should("be.visible");
  cy.getCy("intakecoordinatordashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("intake_coordinator_dashboard");

  });
});
