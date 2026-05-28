// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Role All Screens - ops_manager", () => {
  it("tests all screens for role ops_manager", () => {
    cy.loginAsRole("ops_manager");


  cy.visitWithSemantics("/management/operations-manager-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("operationsmanagerdashboard-screen").should("be.visible");
  cy.getCy("operationsmanagerdashboard-title").should("be.visible");
  cy.getCy("operationsmanagerdashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("operations_manager_dashboard");

  cy.visitWithSemantics("/management/operations-manager-analytics");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("operationsmanageranalytics-screen").should("be.visible");
  cy.getCy("operationsmanageranalytics-title").should("be.visible");
  cy.getCy("operationsmanageranalytics-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("operations_manager_analytics");

  cy.visitWithSemantics("/management/operations-manager-compliance");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("operationsmanagercompliance-screen").should("be.visible");
  cy.getCy("operationsmanagercompliance-title").should("be.visible");
  cy.getCy("operationsmanagercompliance-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("operations_manager_compliance");

  cy.visitWithSemantics("/management/operations-manager-workflow");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("operationsmanagerworkflow-screen").should("be.visible");
  cy.getCy("operationsmanagerworkflow-title").should("be.visible");
  cy.getCy("operationsmanagerworkflow-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("operations_manager_workflow");

  cy.visitWithSemantics("/management/daily-operations");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("dailyoperations-screen").should("be.visible");
  cy.getCy("dailyoperations-title").should("be.visible");
  cy.getCy("dailyoperations-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("daily_operations");

  cy.visitWithSemantics("/management/attendance");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("attendance-screen").should("be.visible");
  cy.getCy("attendance-title").should("be.visible");
  cy.getCy("attendance-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("attendance");

  cy.visitWithSemantics("/management/scheduling-health");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("schedulinghealth-screen").should("be.visible");
  cy.getCy("schedulinghealth-title").should("be.visible");
  cy.getCy("schedulinghealth-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("scheduling_health");

  cy.visitWithSemantics("/management/service-issue");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("serviceissue-screen").should("be.visible");
  cy.getCy("serviceissue-title").should("be.visible");
  cy.getCy("serviceissue-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("service_issue");

  });
});
