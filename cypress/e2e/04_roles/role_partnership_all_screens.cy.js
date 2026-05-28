// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Role All Screens - partnership", () => {
  it("tests all screens for role partnership", () => {
    cy.loginAsRole("partnership");


  cy.visitWithSemantics("/management/partnership-manager-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("partnershipmanagerdashboard-screen").should("be.visible");
  cy.getCy("partnershipmanagerdashboard-title").should("be.visible");
  cy.getCy("partnershipmanagerdashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("partnership_manager_dashboard");

  cy.visitWithSemantics("/management/partnership-manager-analytics");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("partnershipmanageranalytics-screen").should("be.visible");
  cy.getCy("partnershipmanageranalytics-title").should("be.visible");
  cy.getCy("partnershipmanageranalytics-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("partnership_manager_analytics");

  cy.visitWithSemantics("/management/partnership-manager-compliance");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("partnershipmanagercompliance-screen").should("be.visible");
  cy.getCy("partnershipmanagercompliance-title").should("be.visible");
  cy.getCy("partnershipmanagercompliance-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("partnership_manager_compliance");

  cy.visitWithSemantics("/management/partnership-manager-workflow");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("partnershipmanagerworkflow-screen").should("be.visible");
  cy.getCy("partnershipmanagerworkflow-title").should("be.visible");
  cy.getCy("partnershipmanagerworkflow-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("partnership_manager_workflow");

  });
});
