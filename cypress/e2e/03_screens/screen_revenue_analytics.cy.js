// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - revenue_analytics", () => {
  it("opens and verifies screen revenue_analytics", () => {
    cy.loginAsRole("ceo");

  cy.visitWithSemantics("/executive/revenue-analytics");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("revenueanalytics-screen").should("be.visible");
  cy.getCy("revenueanalytics-title").should("be.visible");
  cy.getCy("revenueanalytics-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("revenue_analytics");

  });
});
