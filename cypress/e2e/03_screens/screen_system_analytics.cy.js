// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - system_analytics", () => {
  it("opens and verifies screen system_analytics", () => {
    cy.loginAsRole("system_verification");

  cy.visitWithSemantics("/common/system-analytics");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("systemanalytics-screen").should("be.visible");
  cy.getCy("systemanalytics-title").should("be.visible");
  cy.getCy("systemanalytics-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("system_analytics");

  });
});
