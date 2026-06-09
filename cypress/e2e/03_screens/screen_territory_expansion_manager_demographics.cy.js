// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - territory_expansion_manager_demographics", () => {
  it("opens and verifies screen territory_expansion_manager_demographics", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/business_development/roles/territory_expansion_manager/demographics (Territory Expansion Manager Demographics)...");
  cy.visitWithSemantics("/offices/business_development/roles/territory_expansion_manager/demographics");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Territory Expansion Manager Demographics...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("territoryexpansionmanagerdemographics-screen").should("be.visible");
  cy.getCy("territoryexpansionmanagerdemographics-title").should("be.visible");
  cy.getCy("territoryexpansionmanagerdemographics-content").should("be.visible");
  cy.getCy("dashboard-btn-update-data").should("be.visible");
  cy.getCy("dashboard-btn-generate-report").should("be.visible");
  cy.getCy("dashboard-btn-share-insights").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Territory Expansion Manager Demographics...");
  cy.waitAndSee();
  cy.screenshot("territory_expansion_manager_demographics");
  
  cy.task("log", "✅ PROGRESS: - Verified Territory Expansion Manager Demographics successfully!\n");

  });
});
