// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - scheduling_dashboard", () => {
  it("opens and verifies screen scheduling_dashboard", () => {
    cy.loginAsRole("scheduler");

  cy.visit("/staff/scheduling-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("schedulingdashboard-screen").should("be.visible");
  cy.getCy("schedulingdashboard-title").should("be.visible");
  cy.getCy("schedulingdashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("scheduling_dashboard");

  });
});
