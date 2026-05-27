// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - franchise_owner_reports", () => {
  it("opens and verifies screen franchise_owner_reports", () => {
    cy.loginAsRole("owner");

  cy.visit("/executive/franchise-owner-reports");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("franchiseownerreports-screen").should("be.visible");
  cy.getCy("franchiseownerreports-title").should("be.visible");
  cy.getCy("franchiseownerreports-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("franchise_owner_reports");

  });
});
