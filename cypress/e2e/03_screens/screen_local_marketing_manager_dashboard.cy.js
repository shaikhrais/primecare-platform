// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - local_marketing_manager_dashboard", () => {
  it("opens and verifies screen local_marketing_manager_dashboard", () => {
    cy.loginAsRole("local_marketing");

  cy.visit("/management/local-marketing-manager-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("localmarketingmanagerdashboard-screen").should("be.visible");
  cy.getCy("localmarketingmanagerdashboard-title").should("be.visible");
  cy.getCy("localmarketingmanagerdashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("local_marketing_manager_dashboard");

  });
});
