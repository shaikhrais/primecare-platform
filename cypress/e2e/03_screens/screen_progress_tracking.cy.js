// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - progress_tracking", () => {
  it("opens and verifies screen progress_tracking", () => {
    cy.loginAsRole("physio");

  cy.visitWithSemantics("/clinical/progress-tracking");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("progresstracking-screen").should("be.visible");
  cy.getCy("progresstracking-title").should("be.visible");
  cy.getCy("progresstracking-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("progress_tracking");

  });
});
