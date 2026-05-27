// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - guest_workflow", () => {
  it("opens and verifies screen guest_workflow", () => {
    cy.loginAsRole("guest");

  cy.visit("/common/guest-workflow");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("guestworkflow-screen").should("be.visible");
  cy.getCy("guestworkflow-title").should("be.visible");
  cy.getCy("guestworkflow-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("guest_workflow");

  });
});
