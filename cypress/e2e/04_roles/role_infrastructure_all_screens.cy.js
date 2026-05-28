// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Role All Screens - infrastructure", () => {
  it("tests all screens for role infrastructure", () => {
    cy.loginAsRole("infrastructure");


  cy.visitWithSemantics("/common/infrastructure-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("infrastructuredashboard-screen").should("be.visible");
  cy.getCy("infrastructuredashboard-title").should("be.visible");
  cy.getCy("infrastructuredashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("infrastructure_dashboard");

  cy.visitWithSemantics("/common/architecture-planning-analytics");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("architectureplanninganalytics-screen").should("be.visible");
  cy.getCy("architectureplanninganalytics-title").should("be.visible");
  cy.getCy("architectureplanninganalytics-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("architecture_planning_analytics");

  cy.visitWithSemantics("/common/architecture-planning-compliance");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("architectureplanningcompliance-screen").should("be.visible");
  cy.getCy("architectureplanningcompliance-title").should("be.visible");
  cy.getCy("architectureplanningcompliance-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("architecture_planning_compliance");

  cy.visitWithSemantics("/common/architecture-planning-workflow");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("architectureplanningworkflow-screen").should("be.visible");
  cy.getCy("architectureplanningworkflow-title").should("be.visible");
  cy.getCy("architectureplanningworkflow-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("architecture_planning_workflow");

  cy.visitWithSemantics("/common/infrastructure-analytics");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("infrastructureanalytics-screen").should("be.visible");
  cy.getCy("infrastructureanalytics-title").should("be.visible");
  cy.getCy("infrastructureanalytics-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("infrastructure_analytics");

  cy.visitWithSemantics("/common/infrastructure-compliance");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("infrastructurecompliance-screen").should("be.visible");
  cy.getCy("infrastructurecompliance-title").should("be.visible");
  cy.getCy("infrastructurecompliance-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("infrastructure_compliance");

  cy.visitWithSemantics("/common/infrastructure-workflow");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("infrastructureworkflow-screen").should("be.visible");
  cy.getCy("infrastructureworkflow-title").should("be.visible");
  cy.getCy("infrastructureworkflow-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("infrastructure_workflow");

  });
});
