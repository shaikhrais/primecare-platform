// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - cfo_analytics", () => {
  it("opens and verifies screen cfo_analytics", () => {
    cy.loginAsRole("cfo");

  cy.visit("/executive/cfo-analytics");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("cfoanalytics-screen").should("be.visible");
  cy.getCy("cfoanalytics-title").should("be.visible");
  cy.getCy("cfoanalytics-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("cfo_analytics");

  });
});
