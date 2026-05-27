// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Role All Screens - social_worker", () => {
  it("tests all screens for role social_worker", () => {
    cy.loginAsRole("social_worker");


  cy.visit("/common/social-worker-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("socialworkerdashboard-screen").should("be.visible");
  cy.getCy("socialworkerdashboard-title").should("be.visible");
  cy.getCy("socialworkerdashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("social_worker_dashboard");

  cy.visit("/common/social-worker-analytics");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("socialworkeranalytics-screen").should("be.visible");
  cy.getCy("socialworkeranalytics-title").should("be.visible");
  cy.getCy("socialworkeranalytics-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("social_worker_analytics");

  cy.visit("/common/social-worker-compliance");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("socialworkercompliance-screen").should("be.visible");
  cy.getCy("socialworkercompliance-title").should("be.visible");
  cy.getCy("socialworkercompliance-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("social_worker_compliance");

  cy.visit("/common/social-worker-workflow");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("socialworkerworkflow-screen").should("be.visible");
  cy.getCy("socialworkerworkflow-title").should("be.visible");
  cy.getCy("socialworkerworkflow-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("social_worker_workflow");

  });
});
