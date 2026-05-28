// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - office_compliance", () => {
  it("opens and verifies screen office_compliance", () => {
    cy.loginAsRole("admin");

  cy.visitWithSemantics("/common/office-compliance");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("officecompliance-screen").should("be.visible");
  cy.getCy("officecompliance-title").should("be.visible");
  cy.getCy("officecompliance-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("office_compliance");

  });
});
