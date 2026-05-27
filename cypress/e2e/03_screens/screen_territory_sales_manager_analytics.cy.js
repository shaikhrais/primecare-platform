// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - territory_sales_manager_analytics", () => {
  it("opens and verifies screen territory_sales_manager_analytics", () => {
    cy.loginAsRole("territory_sales");

  cy.visit("/management/territory-sales-manager-analytics");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("territorysalesmanageranalytics-screen").should("be.visible");
  cy.getCy("territorysalesmanageranalytics-title").should("be.visible");
  cy.getCy("territorysalesmanageranalytics-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("territory_sales_manager_analytics");

  });
});
