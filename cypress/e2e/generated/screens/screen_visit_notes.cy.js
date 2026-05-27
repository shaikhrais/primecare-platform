// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - visit_notes", () => {
  it("opens and verifies screen visit_notes", () => {
    cy.loginAsRole("psw");

  cy.visit("/psw/visit-notes");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("visitnotes-screen").should("be.visible");
  cy.getCy("visitnotes-title").should("be.visible");
  cy.getCy("visitnotes-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("visit_notes");

  });
});
