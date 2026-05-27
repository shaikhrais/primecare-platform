// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - partnership_manager_workflow", () => {
  it("opens and verifies screen partnership_manager_workflow", () => {
    cy.loginAsRole("partnership");

  cy.visit("/management/partnership-manager-workflow");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("partnershipmanagerworkflow-screen").should("be.visible");
  cy.getCy("partnershipmanagerworkflow-title").should("be.visible");
  cy.getCy("partnershipmanagerworkflow-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("partnership_manager_workflow");

  });
});
