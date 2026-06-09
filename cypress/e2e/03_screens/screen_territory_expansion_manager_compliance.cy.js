// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - territory_expansion_manager_compliance", () => {
  it("opens and verifies screen territory_expansion_manager_compliance", () => {
    cy.loginAsRole("territory_expansion");

  cy.task("log", "⏳ PROGRESS: - Navigating to /management/territory-expansion-manager-compliance (TerritoryExpansionManagerComplianceScreen)...");
  cy.visitWithSemantics("/management/territory-expansion-manager-compliance");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for TerritoryExpansionManagerComplianceScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("territoryexpansionmanagercompliance-screen").should("be.visible");
  cy.getCy("territoryexpansionmanagercompliance-title").should("be.visible");
  cy.getCy("territoryexpansionmanagercompliance-content").should("be.visible");
  cy.getCy("territory-expansion-btn-generate-report").should("be.visible");
  cy.getCy("territory-expansion-btn-update-strategy").should("be.visible");
  cy.getCy("territory-expansion-btn-request-resources").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for TerritoryExpansionManagerComplianceScreen...");
  cy.waitAndSee();
  cy.screenshot("territory_expansion_manager_compliance");
  
  cy.task("log", "✅ PROGRESS: - Verified TerritoryExpansionManagerComplianceScreen successfully!\n");

  });
});
