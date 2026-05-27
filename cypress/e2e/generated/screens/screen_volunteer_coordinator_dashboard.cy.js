// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - volunteer_coordinator_dashboard", () => {
  it("opens and verifies screen volunteer_coordinator_dashboard", () => {
    cy.loginAsRole("volunteer_coordinator");

  cy.visit("/staff/volunteer-coordinator-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("volunteercoordinatordashboard-screen").should("be.visible");
  cy.getCy("volunteercoordinatordashboard-title").should("be.visible");
  cy.getCy("volunteercoordinatordashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("volunteer_coordinator_dashboard");

  });
});
