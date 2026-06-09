// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - territory_expansion_manager_site_selection", () => {
  it("opens and verifies screen territory_expansion_manager_site_selection", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/business_development/roles/territory_expansion_manager/site-selection (Territory Expansion Manager Site Selection)...");
  cy.visitWithSemantics("/offices/business_development/roles/territory_expansion_manager/site-selection");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Territory Expansion Manager Site Selection...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("territoryexpansionmanagersiteselection-screen").should("be.visible");
  cy.getCy("territoryexpansionmanagersiteselection-title").should("be.visible");
  cy.getCy("territoryexpansionmanagersiteselection-content").should("be.visible");
  cy.getCy("territory-expansion-analyze-btn").should("be.visible");
  cy.getCy("territory-expansion-collaborate-btn").should("be.visible");
  cy.getCy("territory-expansion-recommendation-btn").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Territory Expansion Manager Site Selection...");
  cy.waitAndSee();
  cy.screenshot("territory_expansion_manager_site_selection");
  
  cy.task("log", "✅ PROGRESS: - Verified Territory Expansion Manager Site Selection successfully!\n");

  });
});
