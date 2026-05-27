// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - rmt_dashboard", () => {
  it("opens and verifies screen rmt_dashboard", () => {
    cy.loginAsRole("rmt");

  cy.visit("/allied/rmt-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("rmtdashboard-screen").should("be.visible");
  cy.getCy("rmtdashboard-title").should("be.visible");
  cy.getCy("rmtdashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("rmt_dashboard");

  });
});
