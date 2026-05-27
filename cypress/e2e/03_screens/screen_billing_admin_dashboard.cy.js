// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - billing_admin_dashboard", () => {
  it("opens and verifies screen billing_admin_dashboard", () => {
    cy.loginAsRole("admin");

  cy.visit("/staff/billing-admin-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("billingadmindashboard-screen").should("be.visible");
  cy.getCy("billingadmindashboard-title").should("be.visible");
  cy.getCy("billingadmindashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("billing_admin_dashboard");

  });
});
