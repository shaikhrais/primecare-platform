// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Role All Screens - territory_sales", () => {
  it("tests all screens for role territory_sales", () => {
    cy.loginAsRole("territory_sales");


  cy.visit("/management/territory-sales-manager-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("territorysalesmanagerdashboard-screen").should("be.visible");
  cy.getCy("territorysalesmanagerdashboard-title").should("be.visible");
  cy.getCy("territorysalesmanagerdashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("territory_sales_manager_dashboard");

  cy.visit("/management/territory-sales-manager-analytics");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("territorysalesmanageranalytics-screen").should("be.visible");
  cy.getCy("territorysalesmanageranalytics-title").should("be.visible");
  cy.getCy("territorysalesmanageranalytics-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("territory_sales_manager_analytics");

  cy.visit("/management/territory-sales-manager-compliance");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("territorysalesmanagercompliance-screen").should("be.visible");
  cy.getCy("territorysalesmanagercompliance-title").should("be.visible");
  cy.getCy("territorysalesmanagercompliance-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("territory_sales_manager_compliance");

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
