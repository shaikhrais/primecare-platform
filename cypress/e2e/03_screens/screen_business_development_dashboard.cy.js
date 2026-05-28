// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - business_development_dashboard", () => {
  it("opens and verifies screen business_development_dashboard", () => {
    cy.loginAsRole("bus_dev");

  cy.visitWithSemantics("/common/business-development-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("businessdevelopmentdashboard-screen").should("be.visible");
  cy.getCy("businessdevelopmentdashboard-title").should("be.visible");
  cy.getCy("businessdevelopmentdashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("business_development_dashboard");

  });
});
