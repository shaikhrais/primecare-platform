// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - system_verification_workflow", () => {
  it("opens and verifies screen system_verification_workflow", () => {
    cy.loginAsRole("system_verification");

  cy.visit("/common/system-verification-workflow");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("systemverificationworkflow-screen").should("be.visible");
  cy.getCy("systemverificationworkflow-title").should("be.visible");
  cy.getCy("systemverificationworkflow-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("system_verification_workflow");

  });
});
