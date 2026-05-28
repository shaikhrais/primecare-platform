// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Role All Screens - portal", () => {
  it("tests all screens for role portal", () => {
    cy.loginAsRole("portal");


  cy.visitWithSemantics("/common/portal-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("portaldashboard-screen").should("be.visible");
  cy.getCy("portaldashboard-title").should("be.visible");
  cy.getCy("portaldashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("portal_dashboard");

  cy.visitWithSemantics("/common/portal-analytics");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("portalanalytics-screen").should("be.visible");
  cy.getCy("portalanalytics-title").should("be.visible");
  cy.getCy("portalanalytics-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("portal_analytics");

  cy.visitWithSemantics("/common/portal-compliance");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("portalcompliance-screen").should("be.visible");
  cy.getCy("portalcompliance-title").should("be.visible");
  cy.getCy("portalcompliance-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("portal_compliance");

  cy.visitWithSemantics("/common/portal-workflow");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("portalworkflow-screen").should("be.visible");
  cy.getCy("portalworkflow-title").should("be.visible");
  cy.getCy("portalworkflow-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("portal_workflow");

  });
});
