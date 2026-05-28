// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - system_verification_analytics", () => {
  it("opens and verifies screen system_verification_analytics", () => {
    cy.loginAsRole("system_verification");

  cy.visitWithSemantics("/common/system-verification-analytics");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("systemverificationanalytics-screen").should("be.visible");
  cy.getCy("systemverificationanalytics-title").should("be.visible");
  cy.getCy("systemverificationanalytics-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("system_verification_analytics");

  });
});
