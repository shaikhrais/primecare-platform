// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - office_dashboard", () => {
  it("opens and verifies screen office_dashboard", () => {
    cy.loginAsRole("admin");

  cy.visit("/common/office-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("officedashboard-screen").should("be.visible");
  cy.getCy("officedashboard-title").should("be.visible");
  cy.getCy("officedashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("office_dashboard");

  });
});
