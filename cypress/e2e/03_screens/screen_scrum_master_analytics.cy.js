// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - scrum_master_analytics", () => {
  it("opens and verifies screen scrum_master_analytics", () => {
    cy.loginAsRole("scrum_master");

  cy.visitWithSemantics("/management/scrum-master-analytics");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("scrummasteranalytics-screen").should("be.visible");
  cy.getCy("scrummasteranalytics-title").should("be.visible");
  cy.getCy("scrummasteranalytics-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("scrum_master_analytics");

  });
});
