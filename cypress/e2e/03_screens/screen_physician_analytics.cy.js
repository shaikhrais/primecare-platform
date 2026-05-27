// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - physician_analytics", () => {
  it("opens and verifies screen physician_analytics", () => {
    cy.loginAsRole("physician");

  cy.visit("/clinical/physician-analytics");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("physician analytics-screen").should("be.visible");
  cy.getCy("physician analytics-title").should("be.visible");
  cy.getCy("physician analytics-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("physician_analytics");

  });
});
