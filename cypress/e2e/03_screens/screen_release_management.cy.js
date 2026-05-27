// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - release_management", () => {
  it("opens and verifies screen release_management", () => {
    cy.loginAsRole("cto");

  cy.visit("/executive/release-management");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("releasemanagement-screen").should("be.visible");
  cy.getCy("releasemanagement-title").should("be.visible");
  cy.getCy("releasemanagement-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("release_management");

  });
});
