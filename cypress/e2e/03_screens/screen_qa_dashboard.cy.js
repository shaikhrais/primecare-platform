// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - qa_dashboard", () => {
  it("opens and verifies screen qa_dashboard", () => {
    cy.loginAsRole("system_verification");

  cy.visitWithSemantics("/common/qa-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("qadashboard-screen").should("be.visible");
  cy.getCy("qadashboard-title").should("be.visible");
  cy.getCy("qadashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("qa_dashboard");

  });
});
