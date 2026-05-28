// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - finance_director_analytics", () => {
  it("opens and verifies screen finance_director_analytics", () => {
    cy.loginAsRole("finance_director");

  cy.visitWithSemantics("/executive/finance-director-analytics");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("financedirectoranalytics-screen").should("be.visible");
  cy.getCy("financedirectoranalytics-title").should("be.visible");
  cy.getCy("financedirectoranalytics-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("finance_director_analytics");

  });
});
