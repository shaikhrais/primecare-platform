// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - chiropractor_analytics", () => {
  it("opens and verifies screen chiropractor_analytics", () => {
    cy.loginAsRole("chiropractor");

  cy.visit("/common/chiropractor-analytics");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("chiropractoranalytics-screen").should("be.visible");
  cy.getCy("chiropractoranalytics-title").should("be.visible");
  cy.getCy("chiropractoranalytics-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("chiropractor_analytics");

  });
});
