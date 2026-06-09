// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - territory_sales_manager_reports", () => {
  it("opens and verifies screen territory_sales_manager_reports", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Territory Sales Manager Reports)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Territory Sales Manager Reports...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("territorysalesmanagerreports-screen").should("be.visible");
  cy.getCy("territorysalesmanagerreports-title").should("be.visible");
  cy.getCy("territorysalesmanagerreports-content").should("be.visible");
  cy.getCy("salesreport-btn-refresh").should("be.visible");
  cy.getCy("salesreport-btn-download").should("be.visible");
  cy.getCy("salesreport-btn-customize").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Territory Sales Manager Reports...");
  cy.waitAndSee();
  cy.screenshot("territory_sales_manager_reports");
  
  cy.task("log", "✅ PROGRESS: - Verified Territory Sales Manager Reports successfully!\n");

  });
});
