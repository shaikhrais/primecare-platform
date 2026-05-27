// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Role All Screens - legal", () => {
  it("tests all screens for role legal", () => {
    cy.loginAsRole("legal");


  cy.visit("/executive/legal-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("legaldashboard-screen").should("be.visible");
  cy.getCy("legaldashboard-title").should("be.visible");
  cy.getCy("legaldashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("legal_dashboard");

  cy.visit("/executive/legal-analytics");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("legalanalytics-screen").should("be.visible");
  cy.getCy("legalanalytics-title").should("be.visible");
  cy.getCy("legalanalytics-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("legal_analytics");

  cy.visit("/executive/legal-compliance");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("legalcompliance-screen").should("be.visible");
  cy.getCy("legalcompliance-title").should("be.visible");
  cy.getCy("legalcompliance-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("legal_compliance");

  cy.visit("/executive/legal-workflow");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("legalworkflow-screen").should("be.visible");
  cy.getCy("legalworkflow-title").should("be.visible");
  cy.getCy("legalworkflow-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("legal_workflow");

  });
});
