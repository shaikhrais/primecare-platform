// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Role All Screens - regional_manager_usa", () => {
  it("tests all screens for role regional_manager_usa", () => {
    cy.loginAsRole("regional_manager_usa");


  cy.visit("/management/regional-manager-usa-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("regionalmanagerusadashboard-screen").should("be.visible");
  cy.getCy("regionalmanagerusadashboard-title").should("be.visible");
  cy.getCy("regionalmanagerusadashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("regional_manager_usa_dashboard");

  cy.visit("/management/regional-manager-usa-analytics");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("regionalmanagerusaanalytics-screen").should("be.visible");
  cy.getCy("regionalmanagerusaanalytics-title").should("be.visible");
  cy.getCy("regionalmanagerusaanalytics-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("regional_manager_usa_analytics");

  cy.visit("/management/regional-manager-usa-compliance");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("regionalmanagerusacompliance-screen").should("be.visible");
  cy.getCy("regionalmanagerusacompliance-title").should("be.visible");
  cy.getCy("regionalmanagerusacompliance-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("regional_manager_usa_compliance");

  cy.visit("/management/regional-manager-usa-workflow");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("regionalmanagerusaworkflow-screen").should("be.visible");
  cy.getCy("regionalmanagerusaworkflow-title").should("be.visible");
  cy.getCy("regionalmanagerusaworkflow-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("regional_manager_usa_workflow");

  });
});
