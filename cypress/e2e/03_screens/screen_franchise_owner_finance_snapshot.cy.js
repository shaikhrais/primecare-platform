// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - franchise_owner_finance_snapshot", () => {
  it("opens and verifies screen franchise_owner_finance_snapshot", () => {
    cy.loginAsRole("owner");

  cy.visitWithSemantics("/executive/franchise-owner-finance-snapshot");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("franchiseownerfinancesnapshot-screen").should("be.visible");
  cy.getCy("franchiseownerfinancesnapshot-title").should("be.visible");
  cy.getCy("franchiseownerfinancesnapshot-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("franchise_owner_finance_snapshot");

  });
});
