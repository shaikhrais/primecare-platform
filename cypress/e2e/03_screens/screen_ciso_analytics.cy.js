// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - ciso_analytics", () => {
  it("opens and verifies screen ciso_analytics", () => {
    cy.loginAsRole("ciso");

  cy.visitWithSemantics("/executive/ciso-analytics");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("cisoanalytics-screen").should("be.visible");
  cy.getCy("cisoanalytics-title").should("be.visible");
  cy.getCy("cisoanalytics-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("ciso_analytics");

  });
});
