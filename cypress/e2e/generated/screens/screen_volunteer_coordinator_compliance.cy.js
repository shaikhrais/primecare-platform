// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - volunteer_coordinator_compliance", () => {
  it("opens and verifies screen volunteer_coordinator_compliance", () => {
    cy.loginAsRole("volunteer");

  cy.visit("/staff/volunteer-coordinator-compliance");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("volunteercoordinatorcompliance-screen").should("be.visible");
  cy.getCy("volunteercoordinatorcompliance-title").should("be.visible");
  cy.getCy("volunteercoordinatorcompliance-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("volunteer_coordinator_compliance");

  });
});
