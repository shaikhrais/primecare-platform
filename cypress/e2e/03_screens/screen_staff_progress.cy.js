// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - staff_progress", () => {
  it("opens and verifies screen staff_progress", () => {
    cy.loginAsRole("training_coordinator");

  cy.visit("/staff/staff-progress");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("staffprogress-screen").should("be.visible");
  cy.getCy("staffprogress-title").should("be.visible");
  cy.getCy("staffprogress-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("staff_progress");

  });
});
