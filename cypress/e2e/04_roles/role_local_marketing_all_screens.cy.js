// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Role All Screens - local_marketing", () => {
  it("tests all screens for role local_marketing", () => {
    cy.loginAsRole("local_marketing");


  cy.visitWithSemantics("/management/local-marketing-manager-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("localmarketingmanagerdashboard-screen").should("be.visible");
  cy.getCy("localmarketingmanagerdashboard-title").should("be.visible");
  cy.getCy("localmarketingmanagerdashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("local_marketing_manager_dashboard");

  cy.visitWithSemantics("/management/local-marketing-manager-analytics");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("localmarketingmanageranalytics-screen").should("be.visible");
  cy.getCy("localmarketingmanageranalytics-title").should("be.visible");
  cy.getCy("localmarketingmanageranalytics-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("local_marketing_manager_analytics");

  cy.visitWithSemantics("/management/local-marketing-manager-compliance");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("localmarketingmanagercompliance-screen").should("be.visible");
  cy.getCy("localmarketingmanagercompliance-title").should("be.visible");
  cy.getCy("localmarketingmanagercompliance-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("local_marketing_manager_compliance");

  cy.visitWithSemantics("/management/local-marketing-manager-workflow");
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
