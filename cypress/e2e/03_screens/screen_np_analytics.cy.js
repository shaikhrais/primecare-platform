// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - np_analytics", () => {
  it("opens and verifies screen np_analytics", () => {
    cy.loginAsRole("np");

  cy.visitWithSemantics("/rn/np-analytics");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("nurse practitioner (np) analytics-screen").should("be.visible");
  cy.getCy("nurse practitioner (np) analytics-title").should("be.visible");
  cy.getCy("nurse practitioner (np) analytics-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("np_analytics");

  });
});
