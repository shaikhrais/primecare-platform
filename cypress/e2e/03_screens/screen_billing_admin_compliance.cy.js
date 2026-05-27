// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - billing_admin_compliance", () => {
  it("opens and verifies screen billing_admin_compliance", () => {
    cy.loginAsRole("admin");

  cy.visit("/staff/billing-admin-compliance");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("billingadmincompliance-screen").should("be.visible");
  cy.getCy("billingadmincompliance-title").should("be.visible");
  cy.getCy("billingadmincompliance-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("billing_admin_compliance");

  });
});
