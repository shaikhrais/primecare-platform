// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - franchise_analytics", () => {
  it("opens and verifies screen franchise_analytics", () => {
    cy.loginAsRole("owner");

  cy.visit("/common/franchise-analytics");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("franchiseanalytics-screen").should("be.visible");
  cy.getCy("franchiseanalytics-title").should("be.visible");
  cy.getCy("franchiseanalytics-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("franchise_analytics");

  });
});
