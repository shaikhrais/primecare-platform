// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - cx_director_analytics", () => {
  it("opens and verifies screen cx_director_analytics", () => {
    cy.loginAsRole("cx_director");

  cy.visit("/executive/cx-director-analytics");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("cxdirectoranalytics-screen").should("be.visible");
  cy.getCy("cxdirectoranalytics-title").should("be.visible");
  cy.getCy("cxdirectoranalytics-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("cx_director_analytics");

  });
});
