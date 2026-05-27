// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Role All Screens - gm", () => {
  it("tests all screens for role gm", () => {
    cy.loginAsRole("gm");


  cy.visit("/management/general-manager-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("generalmanagerdashboard-screen").should("be.visible");
  cy.getCy("generalmanagerdashboard-title").should("be.visible");
  cy.getCy("generalmanagerdashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("general_manager_dashboard");

  cy.visit("/management/general-manager-analytics");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("generalmanageranalytics-screen").should("be.visible");
  cy.getCy("generalmanageranalytics-title").should("be.visible");
  cy.getCy("generalmanageranalytics-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("general_manager_analytics");

  cy.visit("/management/general-manager-compliance");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("generalmanagercompliance-screen").should("be.visible");
  cy.getCy("generalmanagercompliance-title").should("be.visible");
  cy.getCy("generalmanagercompliance-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("general_manager_compliance");

  cy.visit("/management/general-manager-workflow");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("generalmanagerworkflow-screen").should("be.visible");
  cy.getCy("generalmanagerworkflow-title").should("be.visible");
  cy.getCy("generalmanagerworkflow-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("general_manager_workflow");

  });
});
