// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - support_analytics", () => {
  it("opens and verifies screen support_analytics", () => {
    cy.loginAsRole("customer_support");

  cy.visit("/common/support-analytics");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("supportanalytics-screen").should("be.visible");
  cy.getCy("supportanalytics-title").should("be.visible");
  cy.getCy("supportanalytics-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("support_analytics");

  });
});
