// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Role All Screens - lpn", () => {
  it("tests all screens for role lpn", () => {
    cy.loginAsRole("lpn");


  cy.visitWithSemantics("/clinical/lpn-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("lpndashboard-screen").should("be.visible");
  cy.getCy("lpndashboard-title").should("be.visible");
  cy.getCy("lpndashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("lpn_dashboard");

  cy.visitWithSemantics("/rpn/lpn-analytics");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("licensed practical nurse (lpn) analytics-screen").should("be.visible");
  cy.getCy("licensed practical nurse (lpn) analytics-title").should("be.visible");
  cy.getCy("licensed practical nurse (lpn) analytics-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("lpn_analytics");

  cy.visitWithSemantics("/rpn/lpn-workflow");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("licensed practical nurse (lpn) compliance workflow-screen").should("be.visible");
  cy.getCy("licensed practical nurse (lpn) compliance workflow-title").should("be.visible");
  cy.getCy("licensed practical nurse (lpn) compliance workflow-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("lpn_workflow");

  });
});
