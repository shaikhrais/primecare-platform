// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Role All Screens - therapist", () => {
  it("tests all screens for role therapist", () => {
    cy.loginAsRole("therapist");


  cy.visit("/allied/therapist-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("therapistdashboard-screen").should("be.visible");
  cy.getCy("therapistdashboard-title").should("be.visible");
  cy.getCy("therapistdashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("therapist_dashboard");

  cy.visit("/allied/therapist-analytics");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("therapist analytics-screen").should("be.visible");
  cy.getCy("therapist analytics-title").should("be.visible");
  cy.getCy("therapist analytics-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("therapist_analytics");

  cy.visit("/allied/therapist-workflow");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("therapist compliance workflow-screen").should("be.visible");
  cy.getCy("therapist compliance workflow-title").should("be.visible");
  cy.getCy("therapist compliance workflow-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("therapist_workflow");

  });
});
