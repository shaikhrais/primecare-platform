// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - caregiver_schedule", () => {
  it("opens and verifies screen caregiver_schedule", () => {
    cy.loginAsRole("caregiver");

  cy.visit("/psw/caregiver-schedule");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("caregiverschedule-screen").should("be.visible");
  cy.getCy("caregiverschedule-title").should("be.visible");
  cy.getCy("caregiverschedule-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("caregiver_schedule");

  });
});
