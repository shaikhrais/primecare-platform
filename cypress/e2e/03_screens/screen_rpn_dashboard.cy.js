// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - rpn_dashboard", () => {
  it("opens and verifies screen rpn_dashboard", () => {
    cy.loginAsRole("rpn");

  cy.visit("/rpn/rpn-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("rpndashboard-screen").should("be.visible");
  cy.getCy("rpndashboard-title").should("be.visible");
  cy.getCy("rpndashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("rpn_dashboard");

  });
});
