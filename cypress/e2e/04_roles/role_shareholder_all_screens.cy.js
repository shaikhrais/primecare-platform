// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Role All Screens - shareholder", () => {
  it("tests all screens for role shareholder", () => {
    cy.loginAsRole("shareholder");


  cy.visit("/executive/shareholder-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("shareholderdashboard-screen").should("be.visible");
  cy.getCy("shareholderdashboard-title").should("be.visible");
  cy.getCy("shareholderdashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("shareholder_dashboard");

  cy.visit("/executive/shareholder-analytics");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("shareholderanalytics-screen").should("be.visible");
  cy.getCy("shareholderanalytics-title").should("be.visible");
  cy.getCy("shareholderanalytics-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("shareholder_analytics");

  cy.visit("/executive/shareholder-compliance");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("shareholdercompliance-screen").should("be.visible");
  cy.getCy("shareholdercompliance-title").should("be.visible");
  cy.getCy("shareholdercompliance-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("shareholder_compliance");

  cy.visit("/executive/shareholder-workflow");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("shareholderworkflow-screen").should("be.visible");
  cy.getCy("shareholderworkflow-title").should("be.visible");
  cy.getCy("shareholderworkflow-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("shareholder_workflow");

  });
});
