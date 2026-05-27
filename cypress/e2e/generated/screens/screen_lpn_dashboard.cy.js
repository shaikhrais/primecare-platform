// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - lpn_dashboard", () => {
  it("opens and verifies screen lpn_dashboard", () => {
    cy.loginAsRole("lpn");

  cy.visit("/clinical/lpn-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("lpndashboard-screen").should("be.visible");
  cy.getCy("lpndashboard-title").should("be.visible");
  cy.getCy("lpndashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("lpn_dashboard");

  });
});
