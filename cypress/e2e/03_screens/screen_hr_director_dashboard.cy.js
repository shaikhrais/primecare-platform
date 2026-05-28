// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - hr_director_dashboard", () => {
  it("opens and verifies screen hr_director_dashboard", () => {
    cy.loginAsRole("hr_director");

  cy.visitWithSemantics("/executive/hr-director-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("hrdirectordashboard-screen").should("be.visible");
  cy.getCy("hrdirectordashboard-title").should("be.visible");
  cy.getCy("hrdirectordashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("hr_director_dashboard");

  });
});
