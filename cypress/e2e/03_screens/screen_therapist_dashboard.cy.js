// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - therapist_dashboard", () => {
  it("opens and verifies screen therapist_dashboard", () => {
    cy.loginAsRole("therapist");

  cy.visit("/allied/therapist-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("therapistdashboard-screen").should("be.visible");
  cy.getCy("therapistdashboard-title").should("be.visible");
  cy.getCy("therapistdashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("therapist_dashboard");

  });
});
