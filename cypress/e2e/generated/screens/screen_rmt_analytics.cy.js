// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - rmt_analytics", () => {
  it("opens and verifies screen rmt_analytics", () => {
    cy.loginAsRole("rmt");

  cy.visit("/allied/rmt-analytics");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("rmtanalytics-screen").should("be.visible");
  cy.getCy("rmtanalytics-title").should("be.visible");
  cy.getCy("rmtanalytics-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("rmt_analytics");

  });
});
