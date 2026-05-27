// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - physician_workflow", () => {
  it("opens and verifies screen physician_workflow", () => {
    cy.loginAsRole("physician");

  cy.visit("/clinical/physician-workflow");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("physician compliance workflow-screen").should("be.visible");
  cy.getCy("physician compliance workflow-title").should("be.visible");
  cy.getCy("physician compliance workflow-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("physician_workflow");

  });
});
