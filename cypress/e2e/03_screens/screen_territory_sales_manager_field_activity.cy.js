// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - territory_sales_manager_field_activity", () => {
  it("opens and verifies screen territory_sales_manager_field_activity", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Territory Sales Manager Field Activity)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Territory Sales Manager Field Activity...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("territorysalesmanagerfieldactivity-screen").should("be.visible");
  cy.getCy("territorysalesmanagerfieldactivity-title").should("be.visible");
  cy.getCy("territorysalesmanagerfieldactivity-content").should("be.visible");
  cy.getCy("dashboard-sales-performance").should("be.visible");
  cy.getCy("dashboard-task-management").should("be.visible");
  cy.getCy("dashboard-customer-feedback").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Territory Sales Manager Field Activity...");
  cy.waitAndSee();
  cy.screenshot("territory_sales_manager_field_activity");
  
  cy.task("log", "✅ PROGRESS: - Verified Territory Sales Manager Field Activity successfully!\n");

  });
});
