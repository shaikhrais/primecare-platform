// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - runtime_verification", () => {
  it("opens and verifies screen runtime_verification", () => {
    cy.loginAsRole("governance");

  cy.visit("/common/runtime-verification");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("runtimeverification-screen").should("be.visible");
  cy.getCy("runtimeverification-title").should("be.visible");
  cy.getCy("runtimeverification-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("runtime_verification");

  });
});
