// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - system_verification_dashboard", () => {
  it("opens and verifies screen system_verification_dashboard", () => {
    cy.loginAsRole("system_verification");

  cy.visitWithSemantics("/common/system-verification-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("systemverificationdashboard-screen").should("be.visible");
  cy.getCy("systemverificationdashboard-title").should("be.visible");
  cy.getCy("systemverificationdashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("system_verification_dashboard");

  });
});
