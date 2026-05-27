// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - rn_analytics", () => {
  it("opens and verifies screen rn_analytics", () => {
    cy.loginAsRole("rn");

  cy.visit("/rn/rn-analytics");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("rnanalytics-screen").should("be.visible");
  cy.getCy("rnanalytics-title").should("be.visible");
  cy.getCy("rnanalytics-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("rn_analytics");

  });
});
