// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - customer_support_compliance", () => {
  it("opens and verifies screen customer_support_compliance", () => {
    cy.loginAsRole("customer_support");

  cy.visit("/common/customer-support-compliance");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("customersupportcompliance-screen").should("be.visible");
  cy.getCy("customersupportcompliance-title").should("be.visible");
  cy.getCy("customersupportcompliance-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("customer_support_compliance");

  });
});
