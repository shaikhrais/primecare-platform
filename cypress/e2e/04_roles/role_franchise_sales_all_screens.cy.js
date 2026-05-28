// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Role All Screens - franchise_sales", () => {
  it("tests all screens for role franchise_sales", () => {
    cy.loginAsRole("franchise_sales");


  cy.visitWithSemantics("/management/franchise-sales-manager-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("franchisesalesmanagerdashboard-screen").should("be.visible");
  cy.getCy("franchisesalesmanagerdashboard-title").should("be.visible");
  cy.getCy("franchisesalesmanagerdashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("franchise_sales_manager_dashboard");

  cy.visitWithSemantics("/executive/franchise-sales-analytics");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("franchise sales manager analytics-screen").should("be.visible");
  cy.getCy("franchise sales manager analytics-title").should("be.visible");
  cy.getCy("franchise sales manager analytics-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("franchise_sales_analytics");

  cy.visitWithSemantics("/executive/franchise-sales-workflow");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("franchise sales manager compliance workflow-screen").should("be.visible");
  cy.getCy("franchise sales manager compliance workflow-title").should("be.visible");
  cy.getCy("franchise sales manager compliance workflow-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("franchise_sales_workflow");

  });
});
