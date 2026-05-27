// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - hr_hiring_dashboard", () => {
  it("opens and verifies screen hr_hiring_dashboard", () => {
    cy.loginAsRole("hr_hiring");

  cy.visit("/staff/hr-hiring-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("hrhiringdashboard-screen").should("be.visible");
  cy.getCy("hrhiringdashboard-title").should("be.visible");
  cy.getCy("hrhiringdashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("hr_hiring_dashboard");

  });
});
