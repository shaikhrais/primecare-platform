// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Role All Screens - vip_manager", () => {
  it("tests all screens for role vip_manager", () => {
    cy.loginAsRole("vip_manager");


  cy.visitWithSemantics("/management/vip-manager-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("vipmanagerdashboard-screen").should("be.visible");
  cy.getCy("vipmanagerdashboard-title").should("be.visible");
  cy.getCy("vipmanagerdashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("vip_manager_dashboard");

  cy.visitWithSemantics("/executive/vip-manager-analytics");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("vip client manager analytics-screen").should("be.visible");
  cy.getCy("vip client manager analytics-title").should("be.visible");
  cy.getCy("vip client manager analytics-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("vip_manager_analytics");

  cy.visitWithSemantics("/executive/vip-manager-workflow");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("vip client manager compliance workflow-screen").should("be.visible");
  cy.getCy("vip client manager compliance workflow-title").should("be.visible");
  cy.getCy("vip client manager compliance workflow-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("vip_manager_workflow");

  });
});
