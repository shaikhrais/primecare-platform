// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - regional_manager_usa_dashboard", () => {
  it("opens and verifies screen regional_manager_usa_dashboard", () => {
    cy.loginAsRole("regional_manager_usa");

  cy.visitWithSemantics("/management/regional-manager-usa-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("regionalmanagerusadashboard-screen").should("be.visible");
  cy.getCy("regionalmanagerusadashboard-title").should("be.visible");
  cy.getCy("regionalmanagerusadashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("regional_manager_usa_dashboard");

  });
});
