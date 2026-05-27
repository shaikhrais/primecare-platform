// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - territory_sales_manager_dashboard", () => {
  it("opens and verifies screen territory_sales_manager_dashboard", () => {
    cy.loginAsRole("territory_sales");

  cy.visit("/management/territory-sales-manager-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("territorysalesmanagerdashboard-screen").should("be.visible");
  cy.getCy("territorysalesmanagerdashboard-title").should("be.visible");
  cy.getCy("territorysalesmanagerdashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("territory_sales_manager_dashboard");

  });
});
