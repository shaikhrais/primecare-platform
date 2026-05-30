// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - brand_management", () => {
  it("opens and verifies screen brand_management", () => {
    cy.loginAsRole("marketing");

  cy.task("log", "⏳ PROGRESS: - Navigating to /management/brand-management (BrandManagementScreen)...");
  cy.visitWithSemantics("/management/brand-management");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for BrandManagementScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("brandmanagement-screen").should("be.visible");
  cy.getCy("brandmanagement-title").should("be.visible");
  cy.getCy("brandmanagement-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for BrandManagementScreen...");
  cy.waitAndSee();
  cy.screenshot("brand_management");
  
  cy.task("log", "✅ PROGRESS: - Verified BrandManagementScreen successfully!\n");

  });
});
