// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - compliance_dashboard", () => {
  it("opens and verifies screen compliance_dashboard", () => {
    cy.loginAsRole("compliance");

  cy.visit("/management/compliance-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("compliancedashboard-screen").should("be.visible");
  cy.getCy("compliancedashboard-title").should("be.visible");
  cy.getCy("compliancedashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("compliance_dashboard");

  });
});
