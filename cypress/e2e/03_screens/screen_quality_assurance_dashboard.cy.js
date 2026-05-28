// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - quality_assurance_dashboard", () => {
  it("opens and verifies screen quality_assurance_dashboard", () => {
    cy.loginAsRole("system_verification");

  cy.visitWithSemantics("/staff/quality-assurance-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("qualityassurancedashboard-screen").should("be.visible");
  cy.getCy("qualityassurancedashboard-title").should("be.visible");
  cy.getCy("qualityassurancedashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("quality_assurance_dashboard");

  });
});
