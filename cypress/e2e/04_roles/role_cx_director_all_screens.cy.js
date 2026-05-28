// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Role All Screens - cx_director", () => {
  it("tests all screens for role cx_director", () => {
    cy.loginAsRole("cx_director");


  cy.visitWithSemantics("/executive/cx-director-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("cxdirectordashboard-screen").should("be.visible");
  cy.getCy("cxdirectordashboard-title").should("be.visible");
  cy.getCy("cxdirectordashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("cx_director_dashboard");

  cy.visitWithSemantics("/executive/cx-director-analytics");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("cxdirectoranalytics-screen").should("be.visible");
  cy.getCy("cxdirectoranalytics-title").should("be.visible");
  cy.getCy("cxdirectoranalytics-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("cx_director_analytics");

  cy.visitWithSemantics("/executive/cx-director-compliance");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("cxdirectorcompliance-screen").should("be.visible");
  cy.getCy("cxdirectorcompliance-title").should("be.visible");
  cy.getCy("cxdirectorcompliance-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("cx_director_compliance");

  cy.visitWithSemantics("/executive/cx-director-workflow");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("cxdirectorworkflow-screen").should("be.visible");
  cy.getCy("cxdirectorworkflow-title").should("be.visible");
  cy.getCy("cxdirectorworkflow-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("cx_director_workflow");

  });
});
