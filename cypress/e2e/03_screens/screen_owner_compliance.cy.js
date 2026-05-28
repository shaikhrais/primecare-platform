// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - owner_compliance", () => {
  it("opens and verifies screen owner_compliance", () => {
    cy.loginAsRole("owner");

  cy.visitWithSemantics("/executive/owner-compliance");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("ownercompliance-screen").should("be.visible");
  cy.getCy("ownercompliance-title").should("be.visible");
  cy.getCy("ownercompliance-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("owner_compliance");

  });
});
