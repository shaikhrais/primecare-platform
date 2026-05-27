// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - billing_admin_workflow", () => {
  it("opens and verifies screen billing_admin_workflow", () => {
    cy.loginAsRole("admin");

  cy.visit("/staff/billing-admin-workflow");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("billingadminworkflow-screen").should("be.visible");
  cy.getCy("billingadminworkflow-title").should("be.visible");
  cy.getCy("billingadminworkflow-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("billing_admin_workflow");

  });
});
