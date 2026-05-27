// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Role All Screens - finance_director", () => {
  it("tests all screens for role finance_director", () => {
    cy.loginAsRole("finance_director");


  cy.visit("/executive/finance-director-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("financedirectordashboard-screen").should("be.visible");
  cy.getCy("financedirectordashboard-title").should("be.visible");
  cy.getCy("financedirectordashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("finance_director_dashboard");

  cy.visit("/executive/finance-director-analytics");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("financedirectoranalytics-screen").should("be.visible");
  cy.getCy("financedirectoranalytics-title").should("be.visible");
  cy.getCy("financedirectoranalytics-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("finance_director_analytics");

  cy.visit("/executive/finance-director-compliance");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("financedirectorcompliance-screen").should("be.visible");
  cy.getCy("financedirectorcompliance-title").should("be.visible");
  cy.getCy("financedirectorcompliance-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("finance_director_compliance");

  cy.visit("/executive/finance-director-workflow");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("financedirectorworkflow-screen").should("be.visible");
  cy.getCy("financedirectorworkflow-title").should("be.visible");
  cy.getCy("financedirectorworkflow-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("finance_director_workflow");

  });
});
