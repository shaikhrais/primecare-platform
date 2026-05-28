// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - local_marketing_manager_analytics", () => {
  it("opens and verifies screen local_marketing_manager_analytics", () => {
    cy.loginAsRole("local_marketing");

  cy.visitWithSemantics("/management/local-marketing-manager-analytics");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("localmarketingmanageranalytics-screen").should("be.visible");
  cy.getCy("localmarketingmanageranalytics-title").should("be.visible");
  cy.getCy("localmarketingmanageranalytics-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("local_marketing_manager_analytics");

  });
});
