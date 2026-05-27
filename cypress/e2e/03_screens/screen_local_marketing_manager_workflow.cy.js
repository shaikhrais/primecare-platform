// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - local_marketing_manager_workflow", () => {
  it("opens and verifies screen local_marketing_manager_workflow", () => {
    cy.loginAsRole("local_marketing");

  cy.visit("/management/local-marketing-manager-workflow");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("localmarketingmanagerworkflow-screen").should("be.visible");
  cy.getCy("localmarketingmanagerworkflow-title").should("be.visible");
  cy.getCy("localmarketingmanagerworkflow-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("local_marketing_manager_workflow");

  });
});
