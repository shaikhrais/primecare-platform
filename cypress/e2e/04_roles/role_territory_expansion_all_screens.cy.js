// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Role All Screens - territory_expansion", () => {
  it("tests all screens for role territory_expansion", () => {
    cy.loginAsRole("territory_expansion");


  cy.visitWithSemantics("/management/territory-expansion-manager-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("territoryexpansionmanagerdashboard-screen").should("be.visible");
  cy.getCy("territoryexpansionmanagerdashboard-title").should("be.visible");
  cy.getCy("territoryexpansionmanagerdashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("territory_expansion_manager_dashboard");

  cy.visitWithSemantics("/management/territory-expansion-manager-analytics");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("territoryexpansionmanageranalytics-screen").should("be.visible");
  cy.getCy("territoryexpansionmanageranalytics-title").should("be.visible");
  cy.getCy("territoryexpansionmanageranalytics-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("territory_expansion_manager_analytics");

  cy.visitWithSemantics("/management/territory-expansion-manager-compliance");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("territoryexpansionmanagercompliance-screen").should("be.visible");
  cy.getCy("territoryexpansionmanagercompliance-title").should("be.visible");
  cy.getCy("territoryexpansionmanagercompliance-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("territory_expansion_manager_compliance");

  cy.visitWithSemantics("/management/territory-expansion-manager-workflow");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("territoryexpansionmanagerworkflow-screen").should("be.visible");
  cy.getCy("territoryexpansionmanagerworkflow-title").should("be.visible");
  cy.getCy("territoryexpansionmanagerworkflow-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("territory_expansion_manager_workflow");

  });
});
