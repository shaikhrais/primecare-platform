// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Role All Screens - scrum_master", () => {
  it("tests all screens for role scrum_master", () => {
    cy.loginAsRole("scrum_master");


  cy.visit("/management/scrum-master-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("scrummasterdashboard-screen").should("be.visible");
  cy.getCy("scrummasterdashboard-title").should("be.visible");
  cy.getCy("scrummasterdashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("scrum_master_dashboard");

  cy.visit("/management/scrum-master-analytics");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("scrummasteranalytics-screen").should("be.visible");
  cy.getCy("scrummasteranalytics-title").should("be.visible");
  cy.getCy("scrummasteranalytics-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("scrum_master_analytics");

  cy.visit("/management/scrum-master-compliance");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("scrummastercompliance-screen").should("be.visible");
  cy.getCy("scrummastercompliance-title").should("be.visible");
  cy.getCy("scrummastercompliance-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("scrum_master_compliance");

  cy.visit("/management/scrum-master-workflow");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("scrummasterworkflow-screen").should("be.visible");
  cy.getCy("scrummasterworkflow-title").should("be.visible");
  cy.getCy("scrummasterworkflow-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("scrum_master_workflow");

  });
});
