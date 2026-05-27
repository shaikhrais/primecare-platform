// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - customer_support_workflow", () => {
  it("opens and verifies screen customer_support_workflow", () => {
    cy.loginAsRole("customer_support");

  cy.visit("/common/customer-support-workflow");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("customersupportworkflow-screen").should("be.visible");
  cy.getCy("customersupportworkflow-title").should("be.visible");
  cy.getCy("customersupportworkflow-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("customer_support_workflow");

  });
});
