// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - franchise_sales_manager_compliance", () => {
  it("opens and verifies screen franchise_sales_manager_compliance", () => {
    cy.loginAsRole("owner");

  cy.visit("/management/franchise-sales-manager-compliance");
  cy.waitAndSee();
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("franchisesalesmanagercompliance-screen").should("be.visible");
  cy.getCy("franchisesalesmanagercompliance-title").should("be.visible");
  cy.getCy("franchisesalesmanagercompliance-content").should("be.visible");

  cy.waitAndSee();
  cy.screenshot("franchise_sales_manager_compliance");

  });
});
