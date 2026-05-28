// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - enterprise_health", () => {
  it("opens and verifies screen enterprise_health", () => {
    cy.loginAsRole("ceo");

  cy.visitWithSemantics("/executive/enterprise-health");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("enterprisehealth-screen").should("be.visible");
  cy.getCy("enterprisehealth-title").should("be.visible");
  cy.getCy("enterprisehealth-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("enterprise_health");

  });
});
