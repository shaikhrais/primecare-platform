// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - volunteer_dashboard", () => {
  it("opens and verifies screen volunteer_dashboard", () => {
    cy.loginAsRole("volunteer");

  cy.visit("/staff/volunteer-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("volunteerdashboard-screen").should("be.visible");
  cy.getCy("volunteerdashboard-title").should("be.visible");
  cy.getCy("volunteerdashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("volunteer_dashboard");

  });
});
