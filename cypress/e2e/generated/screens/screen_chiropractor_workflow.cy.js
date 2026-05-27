// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - chiropractor_workflow", () => {
  it("opens and verifies screen chiropractor_workflow", () => {
    cy.loginAsRole("chiropractor");

  cy.visit("/common/chiropractor-workflow");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("chiropractorworkflow-screen").should("be.visible");
  cy.getCy("chiropractorworkflow-title").should("be.visible");
  cy.getCy("chiropractorworkflow-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("chiropractor_workflow");

  });
});
