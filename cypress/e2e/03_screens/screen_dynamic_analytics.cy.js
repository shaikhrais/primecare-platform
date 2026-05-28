// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - dynamic_analytics", () => {
  it("opens and verifies screen dynamic_analytics", () => {
    cy.loginAsRole("dynamic");

  cy.visitWithSemantics("/common/dynamic-analytics");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("dynamicanalytics-screen").should("be.visible");
  cy.getCy("dynamicanalytics-title").should("be.visible");
  cy.getCy("dynamicanalytics-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("dynamic_analytics");

  });
});
