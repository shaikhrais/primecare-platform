// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Role All Screens - pediatric", () => {
  it("tests all screens for role pediatric", () => {
    cy.loginAsRole("pediatric");


  cy.visit("/clinical/pediatric-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("pediatricdashboard-screen").should("be.visible");
  cy.getCy("pediatricdashboard-title").should("be.visible");
  cy.getCy("pediatricdashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("pediatric_dashboard");

  cy.visit("/clinical/pediatric-analytics");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("pediatric specialist analytics-screen").should("be.visible");
  cy.getCy("pediatric specialist analytics-title").should("be.visible");
  cy.getCy("pediatric specialist analytics-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("pediatric_analytics");

  cy.visit("/clinical/pediatric-workflow");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("pediatric specialist compliance workflow-screen").should("be.visible");
  cy.getCy("pediatric specialist compliance workflow-title").should("be.visible");
  cy.getCy("pediatric specialist compliance workflow-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("pediatric_workflow");

  });
});
