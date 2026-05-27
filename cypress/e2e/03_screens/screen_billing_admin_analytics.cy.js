// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - billing_admin_analytics", () => {
  it("opens and verifies screen billing_admin_analytics", () => {
    cy.loginAsRole("admin");

  cy.visit("/staff/billing-admin-analytics");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("billingadminanalytics-screen").should("be.visible");
  cy.getCy("billingadminanalytics-title").should("be.visible");
  cy.getCy("billingadminanalytics-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("billing_admin_analytics");

  });
});
