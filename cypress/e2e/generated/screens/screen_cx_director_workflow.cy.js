// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - cx_director_workflow", () => {
  it("opens and verifies screen cx_director_workflow", () => {
    cy.loginAsRole("cx_director");

  cy.visit("/executive/cx-director-workflow");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("cxdirectorworkflow-screen").should("be.visible");
  cy.getCy("cxdirectorworkflow-title").should("be.visible");
  cy.getCy("cxdirectorworkflow-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("cx_director_workflow");

  });
});
