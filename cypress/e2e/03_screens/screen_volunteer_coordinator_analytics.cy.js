// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - volunteer_coordinator_analytics", () => {
  it("opens and verifies screen volunteer_coordinator_analytics", () => {
    cy.loginAsRole("volunteer");

  cy.visitWithSemantics("/staff/volunteer-coordinator-analytics");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("volunteercoordinatoranalytics-screen").should("be.visible");
  cy.getCy("volunteercoordinatoranalytics-title").should("be.visible");
  cy.getCy("volunteercoordinatoranalytics-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("volunteer_coordinator_analytics");

  });
});
