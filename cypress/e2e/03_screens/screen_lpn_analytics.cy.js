// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - lpn_analytics", () => {
  it("opens and verifies screen lpn_analytics", () => {
    cy.loginAsRole("lpn");

  cy.visit("/rpn/lpn-analytics");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("licensed practical nurse (lpn) analytics-screen").should("be.visible");
  cy.getCy("licensed practical nurse (lpn) analytics-title").should("be.visible");
  cy.getCy("licensed practical nurse (lpn) analytics-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("lpn_analytics");

  });
});
