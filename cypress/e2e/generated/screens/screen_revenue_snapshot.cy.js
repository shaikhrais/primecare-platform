// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - revenue_snapshot", () => {
  it("opens and verifies screen revenue_snapshot", () => {
    cy.loginAsRole("owner");

  cy.visit("/executive/revenue-snapshot");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("revenuesnapshot-screen").should("be.visible");
  cy.getCy("revenuesnapshot-title").should("be.visible");
  cy.getCy("revenuesnapshot-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("revenue_snapshot");

  });
});
