// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - coo_analytics", () => {
  it("opens and verifies screen coo_analytics", () => {
    cy.loginAsRole("coo");

  cy.visit("/executive/coo-analytics");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("cooanalytics-screen").should("be.visible");
  cy.getCy("cooanalytics-title").should("be.visible");
  cy.getCy("cooanalytics-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("coo_analytics");

  });
});
