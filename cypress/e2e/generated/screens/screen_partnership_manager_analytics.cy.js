// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - partnership_manager_analytics", () => {
  it("opens and verifies screen partnership_manager_analytics", () => {
    cy.loginAsRole("partnership");

  cy.visit("/management/partnership-manager-analytics");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("partnershipmanageranalytics-screen").should("be.visible");
  cy.getCy("partnershipmanageranalytics-title").should("be.visible");
  cy.getCy("partnershipmanageranalytics-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("partnership_manager_analytics");

  });
});
