// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - franchise_overview", () => {
  it("opens and verifies screen franchise_overview", () => {
    cy.loginAsRole("ceo");

  cy.visitWithSemantics("/executive/franchise-overview");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("franchiseoverview-screen").should("be.visible");
  cy.getCy("franchiseoverview-title").should("be.visible");
  cy.getCy("franchiseoverview-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("franchise_overview");

  });
});
