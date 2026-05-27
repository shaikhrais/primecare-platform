// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - documents", () => {
  it("opens and verifies screen documents", () => {
    cy.loginAsRole("patient");

  cy.visit("/common/documents");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("documents-screen").should("be.visible");
  cy.getCy("documents-title").should("be.visible");
  cy.getCy("documents-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("documents");

  });
});
