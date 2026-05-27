// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - hr_manager_workflow", () => {
  it("opens and verifies screen hr_manager_workflow", () => {
    cy.loginAsRole("hr_director");

  cy.visit("/staff/hr-manager-workflow");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("hrmanagerworkflow-screen").should("be.visible");
  cy.getCy("hrmanagerworkflow-title").should("be.visible");
  cy.getCy("hrmanagerworkflow-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("hr_manager_workflow");

  });
});
