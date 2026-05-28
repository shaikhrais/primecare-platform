// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - audit_review", () => {
  it("opens and verifies screen audit_review", () => {
    cy.loginAsRole("compliance");

  cy.visitWithSemantics("/management/audit-review");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("auditreview-screen").should("be.visible");
  cy.getCy("auditreview-title").should("be.visible");
  cy.getCy("auditreview-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("audit_review");

  });
});
