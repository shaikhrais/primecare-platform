// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - franchise_owner_branch_overview", () => {
  it("opens and verifies screen franchise_owner_branch_overview", () => {
    cy.loginAsRole("owner");

  cy.visit("/executive/franchise-owner-branch-overview");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("franchiseownerbranchoverview-screen").should("be.visible");
  cy.getCy("franchiseownerbranchoverview-title").should("be.visible");
  cy.getCy("franchiseownerbranchoverview-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("franchise_owner_branch_overview");

  });
});
