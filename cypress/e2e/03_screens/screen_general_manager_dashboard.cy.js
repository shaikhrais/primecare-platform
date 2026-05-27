// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - general_manager_dashboard", () => {
  it("opens and verifies screen general_manager_dashboard", () => {
    cy.loginAsRole("gm");

  cy.visit("/management/general-manager-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("generalmanagerdashboard-screen").should("be.visible");
  cy.getCy("generalmanagerdashboard-title").should("be.visible");
  cy.getCy("generalmanagerdashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("general_manager_dashboard");

  });
});
