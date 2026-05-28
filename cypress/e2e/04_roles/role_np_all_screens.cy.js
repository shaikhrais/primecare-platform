// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Role All Screens - np", () => {
  it("tests all screens for role np", () => {
    cy.loginAsRole("np");


  cy.visitWithSemantics("/clinical/np-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("npdashboard-screen").should("be.visible");
  cy.getCy("npdashboard-title").should("be.visible");
  cy.getCy("npdashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("np_dashboard");

  cy.visitWithSemantics("/rn/np-analytics");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("nurse practitioner (np) analytics-screen").should("be.visible");
  cy.getCy("nurse practitioner (np) analytics-title").should("be.visible");
  cy.getCy("nurse practitioner (np) analytics-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("np_analytics");

  cy.visitWithSemantics("/rn/np-workflow");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("nurse practitioner (np) compliance workflow-screen").should("be.visible");
  cy.getCy("nurse practitioner (np) compliance workflow-title").should("be.visible");
  cy.getCy("nurse practitioner (np) compliance workflow-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("np_workflow");

  });
});
