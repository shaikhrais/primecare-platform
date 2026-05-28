// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - attendance", () => {
  it("opens and verifies screen attendance", () => {
    cy.loginAsRole("ops_manager");

  cy.visitWithSemantics("/management/attendance");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("attendance-screen").should("be.visible");
  cy.getCy("attendance-title").should("be.visible");
  cy.getCy("attendance-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("attendance");

  });
});
