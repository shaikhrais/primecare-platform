// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - growth_analytics", () => {
  it("opens and verifies screen growth_analytics", () => {
    cy.loginAsRole("bus_dev");

  cy.visit("/management/growth-analytics");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("growthanalytics-screen").should("be.visible");
  cy.getCy("growthanalytics-title").should("be.visible");
  cy.getCy("growthanalytics-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("growth_analytics");

  });
});
