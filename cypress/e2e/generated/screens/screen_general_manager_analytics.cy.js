// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - general_manager_analytics", () => {
  it("opens and verifies screen general_manager_analytics", () => {
    cy.loginAsRole("gm");

  cy.visit("/management/general-manager-analytics");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("generalmanageranalytics-screen").should("be.visible");
  cy.getCy("generalmanageranalytics-title").should("be.visible");
  cy.getCy("generalmanageranalytics-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("general_manager_analytics");

  });
});
