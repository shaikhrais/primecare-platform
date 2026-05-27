// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - cx_director_dashboard", () => {
  it("opens and verifies screen cx_director_dashboard", () => {
    cy.loginAsRole("cx_director");

  cy.visit("/executive/cx-director-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("cxdirectordashboard-screen").should("be.visible");
  cy.getCy("cxdirectordashboard-title").should("be.visible");
  cy.getCy("cxdirectordashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("cx_director_dashboard");

  });
});
