// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - partnership_manager_dashboard", () => {
  it("opens and verifies screen partnership_manager_dashboard", () => {
    cy.loginAsRole("partnership");

  cy.visitWithSemantics("/management/partnership-manager-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("partnershipmanagerdashboard-screen").should("be.visible");
  cy.getCy("partnershipmanagerdashboard-title").should("be.visible");
  cy.getCy("partnershipmanagerdashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("partnership_manager_dashboard");

  });
});
