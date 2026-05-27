// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - intake_analytics", () => {
  it("opens and verifies screen intake_analytics", () => {
    cy.loginAsRole("intake");

  cy.visit("/common/intake-analytics");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("intakeanalytics-screen").should("be.visible");
  cy.getCy("intakeanalytics-title").should("be.visible");
  cy.getCy("intakeanalytics-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("intake_analytics");

  });
});
