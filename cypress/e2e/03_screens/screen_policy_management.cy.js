// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - policy_management", () => {
  it("opens and verifies screen policy_management", () => {
    cy.loginAsRole("compliance");

  cy.visitWithSemantics("/management/policy-management");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("policymanagement-screen").should("be.visible");
  cy.getCy("policymanagement-title").should("be.visible");
  cy.getCy("policymanagement-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("policy_management");

  });
});
