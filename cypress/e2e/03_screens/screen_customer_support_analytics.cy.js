// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - customer_support_analytics", () => {
  it("opens and verifies screen customer_support_analytics", () => {
    cy.loginAsRole("customer_support");

  cy.visitWithSemantics("/common/customer-support-analytics");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("customersupportanalytics-screen").should("be.visible");
  cy.getCy("customersupportanalytics-title").should("be.visible");
  cy.getCy("customersupportanalytics-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("customer_support_analytics");

  });
});
