// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - audit", () => {
  it("opens and verifies screen audit", () => {
    cy.loginAsRole("governance");

  cy.visitWithSemantics("/common/audit");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("audit-screen").should("be.visible");
  cy.getCy("audit-title").should("be.visible");
  cy.getCy("audit-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("audit");

  });
});
