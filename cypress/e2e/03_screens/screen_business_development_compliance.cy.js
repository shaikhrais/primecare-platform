// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - business_development_compliance", () => {
  it("opens and verifies screen business_development_compliance", () => {
    cy.loginAsRole("bus_dev");

  cy.visitWithSemantics("/common/business-development-compliance");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("businessdevelopmentcompliance-screen").should("be.visible");
  cy.getCy("businessdevelopmentcompliance-title").should("be.visible");
  cy.getCy("businessdevelopmentcompliance-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("business_development_compliance");

  });
});
