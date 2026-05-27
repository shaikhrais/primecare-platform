// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - support_workflow", () => {
  it("opens and verifies screen support_workflow", () => {
    cy.loginAsRole("customer_support");

  cy.visit("/common/support-workflow");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("supportworkflow-screen").should("be.visible");
  cy.getCy("supportworkflow-title").should("be.visible");
  cy.getCy("supportworkflow-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("support_workflow");

  });
});
