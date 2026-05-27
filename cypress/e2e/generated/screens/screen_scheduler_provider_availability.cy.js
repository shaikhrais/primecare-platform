// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - scheduler_provider_availability", () => {
  it("opens and verifies screen scheduler_provider_availability", () => {
    cy.loginAsRole("scheduler");

  cy.visit("/staff/scheduler-provider-availability");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("schedulerprovideravailability-screen").should("be.visible");
  cy.getCy("schedulerprovideravailability-title").should("be.visible");
  cy.getCy("schedulerprovideravailability-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("scheduler_provider_availability");

  });
});
