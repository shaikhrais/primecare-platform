// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - cto_analytics", () => {
  it("opens and verifies screen cto_analytics", () => {
    cy.loginAsRole("cto");

  cy.visit("/executive/cto-analytics");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("ctoanalytics-screen").should("be.visible");
  cy.getCy("ctoanalytics-title").should("be.visible");
  cy.getCy("ctoanalytics-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("cto_analytics");

  });
});
