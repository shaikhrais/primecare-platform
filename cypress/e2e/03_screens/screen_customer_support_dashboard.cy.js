// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - customer_support_dashboard", () => {
  it("opens and verifies screen customer_support_dashboard", () => {
    cy.loginAsRole("dynamic");

  cy.visit("/common/customer-support-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("customersupportdashboard-screen").should("be.visible");
  cy.getCy("customersupportdashboard-title").should("be.visible");
  cy.getCy("customersupportdashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("customer_support_dashboard");

  });
});
