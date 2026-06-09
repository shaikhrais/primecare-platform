// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - territory_sales_manager_conversions", () => {
  it("opens and verifies screen territory_sales_manager_conversions", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Territory Sales Manager Conversions)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Territory Sales Manager Conversions...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("territorysalesmanagerconversions-screen").should("be.visible");
  cy.getCy("territorysalesmanagerconversions-title").should("be.visible");
  cy.getCy("territorysalesmanagerconversions-content").should("be.visible");
  cy.getCy("sales-dashboard-btn-generate-report").should("be.visible");
  cy.getCy("sales-dashboard-btn-analyze-trends").should("be.visible");
  cy.getCy("sales-dashboard-btn-identify-improvements").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Territory Sales Manager Conversions...");
  cy.waitAndSee();
  cy.screenshot("territory_sales_manager_conversions");
  
  cy.task("log", "✅ PROGRESS: - Verified Territory Sales Manager Conversions successfully!\n");

  });
});
