// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - intake_coordinator_analytics", () => {
  it("opens and verifies screen intake_coordinator_analytics", () => {
    cy.loginAsRole("intake");

  cy.visit("/staff/intake-coordinator-analytics");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("intakecoordinatoranalytics-screen").should("be.visible");
  cy.getCy("intakecoordinatoranalytics-title").should("be.visible");
  cy.getCy("intakecoordinatoranalytics-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("intake_coordinator_analytics");

  });
});
