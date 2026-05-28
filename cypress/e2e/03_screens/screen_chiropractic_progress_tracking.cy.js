// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - chiropractic_progress_tracking", () => {
  it("opens and verifies screen chiropractic_progress_tracking", () => {
    cy.loginAsRole("chiropractor");

  cy.visitWithSemantics("/allied/chiropractic-progress-tracking");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("chiropracticprogresstracking-screen").should("be.visible");
  cy.getCy("chiropracticprogresstracking-title").should("be.visible");
  cy.getCy("chiropracticprogresstracking-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("chiropractic_progress_tracking");

  });
});
