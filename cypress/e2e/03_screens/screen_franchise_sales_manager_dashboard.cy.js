// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - franchise_sales_manager_dashboard", () => {
  it("opens and verifies screen franchise_sales_manager_dashboard", () => {
    cy.loginAsRole("franchise_sales");

  cy.visitWithSemantics("/management/franchise-sales-manager-dashboard");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("franchisesalesmanagerdashboard-screen").should("be.visible");
  cy.getCy("franchisesalesmanagerdashboard-title").should("be.visible");
  cy.getCy("franchisesalesmanagerdashboard-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("franchise_sales_manager_dashboard");

  });
});
