// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Role All Screens - physician", () => {
  it("tests all screens for role physician", () => {
    cy.loginAsRole("physician");


  cy.visit("/clinical/physician-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("physiciandashboard-screen").should("be.visible");
  cy.getCy("physiciandashboard-title").should("be.visible");
  cy.getCy("physiciandashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("physician_dashboard");

  cy.visit("/clinical/physician-analytics");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("physician analytics-screen").should("be.visible");
  cy.getCy("physician analytics-title").should("be.visible");
  cy.getCy("physician analytics-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("physician_analytics");

  cy.visit("/clinical/physician-workflow");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("physician compliance workflow-screen").should("be.visible");
  cy.getCy("physician compliance workflow-title").should("be.visible");
  cy.getCy("physician compliance workflow-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("physician_workflow");

  });
});
