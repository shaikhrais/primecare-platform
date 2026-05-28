// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Role All Screens - employee", () => {
  it("tests all screens for role employee", () => {
    cy.loginAsRole("employee");


  cy.visitWithSemantics("/staff/employee-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("employeedashboard-screen").should("be.visible");
  cy.getCy("employeedashboard-title").should("be.visible");
  cy.getCy("employeedashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("employee_dashboard");

  cy.visitWithSemantics("/staff/employee-analytics");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("employee analytics-screen").should("be.visible");
  cy.getCy("employee analytics-title").should("be.visible");
  cy.getCy("employee analytics-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("employee_analytics");

  cy.visitWithSemantics("/staff/employee-workflow");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("employee compliance workflow-screen").should("be.visible");
  cy.getCy("employee compliance workflow-title").should("be.visible");
  cy.getCy("employee compliance workflow-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("employee_workflow");

  });
});
