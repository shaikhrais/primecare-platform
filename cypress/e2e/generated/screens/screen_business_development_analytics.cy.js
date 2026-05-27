// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - business_development_analytics", () => {
  it("opens and verifies screen business_development_analytics", () => {
    cy.loginAsRole("bus_dev");

  cy.visit("/common/business-development-analytics");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("businessdevelopmentanalytics-screen").should("be.visible");
  cy.getCy("businessdevelopmentanalytics-title").should("be.visible");
  cy.getCy("businessdevelopmentanalytics-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("business_development_analytics");

  });
});
