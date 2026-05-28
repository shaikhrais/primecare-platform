// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - shareholder_analytics", () => {
  it("opens and verifies screen shareholder_analytics", () => {
    cy.loginAsRole("shareholder");

  cy.visitWithSemantics("/executive/shareholder-analytics");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("shareholderanalytics-screen").should("be.visible");
  cy.getCy("shareholderanalytics-title").should("be.visible");
  cy.getCy("shareholderanalytics-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("shareholder_analytics");

  });
});
