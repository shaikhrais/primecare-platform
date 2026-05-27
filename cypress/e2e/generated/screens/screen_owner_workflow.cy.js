// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - owner_workflow", () => {
  it("opens and verifies screen owner_workflow", () => {
    cy.loginAsRole("owner");

  cy.visit("/executive/owner-workflow");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("ownerworkflow-screen").should("be.visible");
  cy.getCy("ownerworkflow-title").should("be.visible");
  cy.getCy("ownerworkflow-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("owner_workflow");

  });
});
