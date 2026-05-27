// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - rpn_analytics", () => {
  it("opens and verifies screen rpn_analytics", () => {
    cy.loginAsRole("rpn");

  cy.visit("/rpn/rpn-analytics");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("rpnanalytics-screen").should("be.visible");
  cy.getCy("rpnanalytics-title").should("be.visible");
  cy.getCy("rpnanalytics-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("rpn_analytics");

  });
});
