// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - franchise_compliance", () => {
  it("opens and verifies screen franchise_compliance", () => {
    cy.loginAsRole("owner");

  cy.visitWithSemantics("/common/franchise-compliance");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("franchisecompliance-screen").should("be.visible");
  cy.getCy("franchisecompliance-title").should("be.visible");
  cy.getCy("franchisecompliance-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("franchise_compliance");

  });
});
