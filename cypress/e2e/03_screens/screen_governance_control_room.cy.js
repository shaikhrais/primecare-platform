// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - governance_control_room", () => {
  it("opens and verifies screen governance_control_room", () => {
    cy.loginAsRole("governance");

  cy.visit("/common/governance-control-room");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("governancecontrolroom-screen").should("be.visible");
  cy.getCy("governancecontrolroom-title").should("be.visible");
  cy.getCy("governancecontrolroom-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("governance_control_room");

  });
});
