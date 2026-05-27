// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - hsw_schedule", () => {
  it("opens and verifies screen hsw_schedule", () => {
    cy.loginAsRole("hsw");

  cy.visit("/clinical/hsw-schedule");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("hswschedule-screen").should("be.visible");
  cy.getCy("hswschedule-title").should("be.visible");
  cy.getCy("hswschedule-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("hsw_schedule");

  });
});
