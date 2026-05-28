// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Role All Screens - cns", () => {
  it("tests all screens for role cns", () => {
    cy.loginAsRole("cns");


  cy.visitWithSemantics("/clinical/cns-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("cnsdashboard-screen").should("be.visible");
  cy.getCy("cnsdashboard-title").should("be.visible");
  cy.getCy("cnsdashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("cns_dashboard");

  cy.visitWithSemantics("/rn/cns-analytics");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("clinical nurse specialist analytics-screen").should("be.visible");
  cy.getCy("clinical nurse specialist analytics-title").should("be.visible");
  cy.getCy("clinical nurse specialist analytics-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("cns_analytics");

  cy.visitWithSemantics("/rn/cns-workflow");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("clinical nurse specialist compliance workflow-screen").should("be.visible");
  cy.getCy("clinical nurse specialist compliance workflow-title").should("be.visible");
  cy.getCy("clinical nurse specialist compliance workflow-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("cns_workflow");

  });
});
