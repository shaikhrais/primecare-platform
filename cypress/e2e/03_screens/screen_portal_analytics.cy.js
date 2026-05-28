// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - portal_analytics", () => {
  it("opens and verifies screen portal_analytics", () => {
    cy.loginAsRole("portal");

  cy.visitWithSemantics("/common/portal-analytics");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("portalanalytics-screen").should("be.visible");
  cy.getCy("portalanalytics-title").should("be.visible");
  cy.getCy("portalanalytics-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("portal_analytics");

  });
});
