// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Role All Screens - ciso", () => {
  it("tests all screens for role ciso", () => {
    cy.loginAsRole("ciso");


  cy.visitWithSemantics("/executive/ciso-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("cisodashboard-screen").should("be.visible");
  cy.getCy("cisodashboard-title").should("be.visible");
  cy.getCy("cisodashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("ciso_dashboard");

  cy.visitWithSemantics("/executive/ciso-analytics");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("cisoanalytics-screen").should("be.visible");
  cy.getCy("cisoanalytics-title").should("be.visible");
  cy.getCy("cisoanalytics-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("ciso_analytics");

  cy.visitWithSemantics("/executive/ciso-compliance");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("cisocompliance-screen").should("be.visible");
  cy.getCy("cisocompliance-title").should("be.visible");
  cy.getCy("cisocompliance-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("ciso_compliance");

  cy.visitWithSemantics("/executive/ciso-workflow");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("cisoworkflow-screen").should("be.visible");
  cy.getCy("cisoworkflow-title").should("be.visible");
  cy.getCy("cisoworkflow-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("ciso_workflow");

  });
});
