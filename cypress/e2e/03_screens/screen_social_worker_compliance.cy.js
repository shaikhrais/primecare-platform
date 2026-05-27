// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - social_worker_compliance", () => {
  it("opens and verifies screen social_worker_compliance", () => {
    cy.loginAsRole("social_worker");

  cy.visit("/common/social-worker-compliance");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("socialworkercompliance-screen").should("be.visible");
  cy.getCy("socialworkercompliance-title").should("be.visible");
  cy.getCy("socialworkercompliance-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("social_worker_compliance");

  });
});
