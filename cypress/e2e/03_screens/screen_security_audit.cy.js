// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - security_audit", () => {
  it("opens and verifies screen security_audit", () => {
    cy.loginAsRole("cto");

  cy.visitWithSemantics("/executive/security-audit");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("securityaudit-screen").should("be.visible");
  cy.getCy("securityaudit-title").should("be.visible");
  cy.getCy("securityaudit-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("security_audit");

  });
});
