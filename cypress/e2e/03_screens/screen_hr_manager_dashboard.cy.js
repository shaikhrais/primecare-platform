// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - hr_manager_dashboard", () => {
  it("opens and verifies screen hr_manager_dashboard", () => {
    cy.loginAsRole("hr_director");

  cy.visitWithSemantics("/staff/hr-manager-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("hrmanagerdashboard-screen").should("be.visible");
  cy.getCy("hrmanagerdashboard-title").should("be.visible");
  cy.getCy("hrmanagerdashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("hr_manager_dashboard");

  });
});
