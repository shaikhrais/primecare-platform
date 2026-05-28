// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - dynamic_compliance", () => {
  it("opens and verifies screen dynamic_compliance", () => {
    cy.loginAsRole("dynamic");

  cy.visitWithSemantics("/common/dynamic-compliance");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("dynamiccompliance-screen").should("be.visible");
  cy.getCy("dynamiccompliance-title").should("be.visible");
  cy.getCy("dynamiccompliance-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("dynamic_compliance");

  });
});
