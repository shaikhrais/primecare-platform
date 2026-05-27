// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - resolution_tracking", () => {
  it("opens and verifies screen resolution_tracking", () => {
    cy.loginAsRole("customer_support");

  cy.visit("/staff/resolution-tracking");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("resolutiontracking-screen").should("be.visible");
  cy.getCy("resolutiontracking-title").should("be.visible");
  cy.getCy("resolutiontracking-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("resolution_tracking");

  });
});
