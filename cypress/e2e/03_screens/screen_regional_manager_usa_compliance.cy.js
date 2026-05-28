// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - regional_manager_usa_compliance", () => {
  it("opens and verifies screen regional_manager_usa_compliance", () => {
    cy.loginAsRole("regional_manager_usa");

  cy.visitWithSemantics("/management/regional-manager-usa-compliance");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("regionalmanagerusacompliance-screen").should("be.visible");
  cy.getCy("regionalmanagerusacompliance-title").should("be.visible");
  cy.getCy("regionalmanagerusacompliance-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("regional_manager_usa_compliance");

  });
});
