// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - franchise_sales_manager_analytics", () => {
  it("opens and verifies screen franchise_sales_manager_analytics", () => {
    cy.loginAsRole("owner");

  cy.visit("/management/franchise-sales-manager-analytics");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("franchisesalesmanageranalytics-screen").should("be.visible");
  cy.getCy("franchisesalesmanageranalytics-title").should("be.visible");
  cy.getCy("franchisesalesmanageranalytics-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("franchise_sales_manager_analytics");

  });
});
