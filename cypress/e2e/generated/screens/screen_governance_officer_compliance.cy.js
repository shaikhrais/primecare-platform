// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - governance_officer_compliance", () => {
  it("opens and verifies screen governance_officer_compliance", () => {
    cy.loginAsRole("governance");

  cy.visit("/management/governance-officer-compliance");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("governanceofficercompliance-screen").should("be.visible");
  cy.getCy("governanceofficercompliance-title").should("be.visible");
  cy.getCy("governanceofficercompliance-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("governance_officer_compliance");

  });
});
