// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - shared_stubs", () => {
  it("opens and verifies screen shared_stubs", () => {
    cy.loginAsRole("dynamic");

  cy.visit("/common/shared-stubs");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("sharedstubs-screen").should("be.visible");
  cy.getCy("sharedstubs-title").should("be.visible");
  cy.getCy("sharedstubs-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("shared_stubs");

  });
});
