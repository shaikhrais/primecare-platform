// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - scrum_master_workflow", () => {
  it("opens and verifies screen scrum_master_workflow", () => {
    cy.loginAsRole("scrum_master");

  cy.visit("/management/scrum-master-workflow");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("scrummasterworkflow-screen").should("be.visible");
  cy.getCy("scrummasterworkflow-title").should("be.visible");
  cy.getCy("scrummasterworkflow-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("scrum_master_workflow");

  });
});
