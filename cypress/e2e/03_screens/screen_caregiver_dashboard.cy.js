// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - caregiver_dashboard", () => {
  it("opens and verifies screen caregiver_dashboard", () => {
    cy.loginAsRole("caregiver");

  cy.visitWithSemantics("/common/caregiver-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("caregiverdashboard-screen").should("be.visible");
  cy.getCy("caregiverdashboard-title").should("be.visible");
  cy.getCy("caregiverdashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("caregiver_dashboard");

  });
});
