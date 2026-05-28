// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Role All Screens - dynamic", () => {
  it("tests all screens for role dynamic", () => {
    cy.loginAsRole("dynamic");


  cy.visitWithSemantics("/common/customer-support-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("customersupportdashboard-screen").should("be.visible");
  cy.getCy("customersupportdashboard-title").should("be.visible");
  cy.getCy("customersupportdashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("customer_support_dashboard");

  cy.visitWithSemantics("/common/support-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("supportdashboard-screen").should("be.visible");
  cy.getCy("supportdashboard-title").should("be.visible");
  cy.getCy("supportdashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("support_dashboard");

  cy.visitWithSemantics("/common/dynamic-analytics");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("dynamicanalytics-screen").should("be.visible");
  cy.getCy("dynamicanalytics-title").should("be.visible");
  cy.getCy("dynamicanalytics-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("dynamic_analytics");

  cy.visitWithSemantics("/common/dynamic-compliance");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("dynamiccompliance-screen").should("be.visible");
  cy.getCy("dynamiccompliance-title").should("be.visible");
  cy.getCy("dynamiccompliance-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("dynamic_compliance");

  cy.visitWithSemantics("/common/dynamic-workflow");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("dynamicworkflow-screen").should("be.visible");
  cy.getCy("dynamicworkflow-title").should("be.visible");
  cy.getCy("dynamicworkflow-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("dynamic_workflow");

  cy.visitWithSemantics("/common/shared-stubs");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("sharedstubs-screen").should("be.visible");
  cy.getCy("sharedstubs-title").should("be.visible");
  cy.getCy("sharedstubs-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("shared_stubs");

  });
});
