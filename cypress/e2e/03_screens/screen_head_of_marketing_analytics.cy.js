// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - head_of_marketing_analytics", () => {
  it("opens and verifies screen head_of_marketing_analytics", () => {
    cy.loginAsRole("marketing");

  cy.visitWithSemantics("/management/head-of-marketing-analytics");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("headofmarketinganalytics-screen").should("be.visible");
  cy.getCy("headofmarketinganalytics-title").should("be.visible");
  cy.getCy("headofmarketinganalytics-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("head_of_marketing_analytics");

  });
});
