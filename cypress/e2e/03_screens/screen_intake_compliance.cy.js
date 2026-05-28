// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - intake_compliance", () => {
  it("opens and verifies screen intake_compliance", () => {
    cy.loginAsRole("intake");

  cy.visitWithSemantics("/common/intake-compliance");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("intakecompliance-screen").should("be.visible");
  cy.getCy("intakecompliance-title").should("be.visible");
  cy.getCy("intakecompliance-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("intake_compliance");

  });
});
