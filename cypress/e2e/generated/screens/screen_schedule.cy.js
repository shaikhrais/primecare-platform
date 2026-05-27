// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - schedule", () => {
  it("opens and verifies screen schedule", () => {
    cy.loginAsRole("caregiver");

  cy.visit("/psw/schedule");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("schedule-screen").should("be.visible");
  cy.getCy("schedule-title").should("be.visible");
  cy.getCy("schedule-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("schedule");

  });
});
