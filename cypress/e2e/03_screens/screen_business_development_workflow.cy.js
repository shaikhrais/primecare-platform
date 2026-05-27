// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - business_development_workflow", () => {
  it("opens and verifies screen business_development_workflow", () => {
    cy.loginAsRole("bus_dev");

  cy.visit("/common/business-development-workflow");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("businessdevelopmentworkflow-screen").should("be.visible");
  cy.getCy("businessdevelopmentworkflow-title").should("be.visible");
  cy.getCy("businessdevelopmentworkflow-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("business_development_workflow");

  });
});
