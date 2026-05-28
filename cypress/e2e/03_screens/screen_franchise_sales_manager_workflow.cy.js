// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - franchise_sales_manager_workflow", () => {
  it("opens and verifies screen franchise_sales_manager_workflow", () => {
    cy.loginAsRole("owner");

  cy.visitWithSemantics("/management/franchise-sales-manager-workflow");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("franchisesalesmanagerworkflow-screen").should("be.visible");
  cy.getCy("franchisesalesmanagerworkflow-title").should("be.visible");
  cy.getCy("franchisesalesmanagerworkflow-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("franchise_sales_manager_workflow");

  });
});
