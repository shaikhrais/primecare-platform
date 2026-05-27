// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - social_worker_workflow", () => {
  it("opens and verifies screen social_worker_workflow", () => {
    cy.loginAsRole("social_worker");

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
