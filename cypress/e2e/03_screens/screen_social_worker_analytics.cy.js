// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - social_worker_analytics", () => {
  it("opens and verifies screen social_worker_analytics", () => {
    cy.loginAsRole("social_worker");

  cy.visit("/common/social-worker-analytics");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("socialworkeranalytics-screen").should("be.visible");
  cy.getCy("socialworkeranalytics-title").should("be.visible");
  cy.getCy("socialworkeranalytics-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("social_worker_analytics");

  });
});
