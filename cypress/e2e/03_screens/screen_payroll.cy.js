// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - payroll", () => {
  it("opens and verifies screen payroll", () => {
    cy.loginAsRole("cfo");

  cy.visit("/executive/payroll");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("payroll-screen").should("be.visible");
  cy.getCy("payroll-title").should("be.visible");
  cy.getCy("payroll-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("payroll");

  });
});
