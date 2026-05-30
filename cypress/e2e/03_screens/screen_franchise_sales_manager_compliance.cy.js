// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - franchise_sales_manager_compliance", () => {
  it("opens and verifies screen franchise_sales_manager_compliance", () => {
    cy.loginAsRole("owner");

  cy.task("log", "⏳ PROGRESS: - Navigating to /management/franchise-sales-manager-compliance (FranchiseSalesManagerComplianceScreen)...");
  cy.visitWithSemantics("/management/franchise-sales-manager-compliance");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for FranchiseSalesManagerComplianceScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("franchisesalesmanagercompliance-screen").should("be.visible");
  cy.getCy("franchisesalesmanagercompliance-title").should("be.visible");
  cy.getCy("franchisesalesmanagercompliance-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for FranchiseSalesManagerComplianceScreen...");
  cy.waitAndSee();
  cy.screenshot("franchise_sales_manager_compliance");
  
  cy.task("log", "✅ PROGRESS: - Verified FranchiseSalesManagerComplianceScreen successfully!\n");

  });
});
