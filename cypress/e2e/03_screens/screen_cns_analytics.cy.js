// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - cns_analytics", () => {
  it("opens and verifies screen cns_analytics", () => {
    cy.loginAsRole("cns");

  cy.visitWithSemantics("/rn/cns-analytics");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("clinical nurse specialist analytics-screen").should("be.visible");
  cy.getCy("clinical nurse specialist analytics-title").should("be.visible");
  cy.getCy("clinical nurse specialist analytics-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("cns_analytics");

  });
});
