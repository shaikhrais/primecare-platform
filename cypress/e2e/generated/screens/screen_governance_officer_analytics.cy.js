// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - governance_officer_analytics", () => {
  it("opens and verifies screen governance_officer_analytics", () => {
    cy.loginAsRole("governance");

  cy.visit("/management/governance-officer-analytics");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("governanceofficeranalytics-screen").should("be.visible");
  cy.getCy("governanceofficeranalytics-title").should("be.visible");
  cy.getCy("governanceofficeranalytics-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("governance_officer_analytics");

  });
});
