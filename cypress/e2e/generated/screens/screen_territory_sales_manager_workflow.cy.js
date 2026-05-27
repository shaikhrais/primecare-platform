// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - territory_sales_manager_workflow", () => {
  it("opens and verifies screen territory_sales_manager_workflow", () => {
    cy.loginAsRole("territory_sales");

  cy.visit("/management/territory-sales-manager-workflow");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("territorysalesmanagerworkflow-screen").should("be.visible");
  cy.getCy("territorysalesmanagerworkflow-title").should("be.visible");
  cy.getCy("territorysalesmanagerworkflow-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("territory_sales_manager_workflow");

  });
});
