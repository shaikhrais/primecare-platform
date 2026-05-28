// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Role All Screens - regional_bdm", () => {
  it("tests all screens for role regional_bdm", () => {
    cy.loginAsRole("regional_bdm");


  cy.visitWithSemantics("/management/regional-bdm-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("regionalbdmdashboard-screen").should("be.visible");
  cy.getCy("regionalbdmdashboard-title").should("be.visible");
  cy.getCy("regionalbdmdashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("regional_bdm_dashboard");

  cy.visitWithSemantics("/management/regional-bdm-analytics");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("regionalbdmanalytics-screen").should("be.visible");
  cy.getCy("regionalbdmanalytics-title").should("be.visible");
  cy.getCy("regionalbdmanalytics-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("regional_bdm_analytics");

  cy.visitWithSemantics("/management/regional-bdm-compliance");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("regionalbdmcompliance-screen").should("be.visible");
  cy.getCy("regionalbdmcompliance-title").should("be.visible");
  cy.getCy("regionalbdmcompliance-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("regional_bdm_compliance");

  cy.visitWithSemantics("/management/regional-bdm-workflow");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("regionalbdmworkflow-screen").should("be.visible");
  cy.getCy("regionalbdmworkflow-title").should("be.visible");
  cy.getCy("regionalbdmworkflow-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("regional_bdm_workflow");

  });
});
