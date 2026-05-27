// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - hr_director_workflow", () => {
  it("opens and verifies screen hr_director_workflow", () => {
    cy.loginAsRole("hr_director");

  cy.visit("/executive/hr-director-workflow");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("hrdirectorworkflow-screen").should("be.visible");
  cy.getCy("hrdirectorworkflow-title").should("be.visible");
  cy.getCy("hrdirectorworkflow-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("hr_director_workflow");

  });
});
