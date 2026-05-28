// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - social_worker_dashboard", () => {
  it("opens and verifies screen social_worker_dashboard", () => {
    cy.loginAsRole("social_worker");

  cy.visitWithSemantics("/common/social-worker-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("socialworkerdashboard-screen").should("be.visible");
  cy.getCy("socialworkerdashboard-title").should("be.visible");
  cy.getCy("socialworkerdashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("social_worker_dashboard");

  });
});
