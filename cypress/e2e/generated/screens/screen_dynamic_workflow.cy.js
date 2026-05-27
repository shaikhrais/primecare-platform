// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - dynamic_workflow", () => {
  it("opens and verifies screen dynamic_workflow", () => {
    cy.loginAsRole("dynamic");

  cy.visit("/common/dynamic-workflow");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("dynamicworkflow-screen").should("be.visible");
  cy.getCy("dynamicworkflow-title").should("be.visible");
  cy.getCy("dynamicworkflow-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("dynamic_workflow");

  });
});
