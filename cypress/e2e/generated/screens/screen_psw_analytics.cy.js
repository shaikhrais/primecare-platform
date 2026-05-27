// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - psw_analytics", () => {
  it("opens and verifies screen psw_analytics", () => {
    cy.loginAsRole("psw");

  cy.visit("/psw/psw-analytics");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("pswanalytics-screen").should("be.visible");
  cy.getCy("pswanalytics-title").should("be.visible");
  cy.getCy("pswanalytics-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("psw_analytics");

  });
});
