// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - governance_officer_dashboard", () => {
  it("opens and verifies screen governance_officer_dashboard", () => {
    cy.loginAsRole("governance");

  cy.visitWithSemantics("/management/governance-officer-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("governanceofficerdashboard-screen").should("be.visible");
  cy.getCy("governanceofficerdashboard-title").should("be.visible");
  cy.getCy("governanceofficerdashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("governance_officer_dashboard");

  });
});
