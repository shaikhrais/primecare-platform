// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - territory_expansion_manager_reports", () => {
  it("opens and verifies screen territory_expansion_manager_reports", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/business_development/roles/territory_expansion_manager/reports (Territory Expansion Manager Reports)...");
  cy.visitWithSemantics("/offices/business_development/roles/territory_expansion_manager/reports");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Territory Expansion Manager Reports...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("territoryexpansionmanagerreports-screen").should("be.visible");
  cy.getCy("territoryexpansionmanagerreports-title").should("be.visible");
  cy.getCy("territoryexpansionmanagerreports-content").should("be.visible");
  cy.getCy("territory-expansion-btn-review").should("be.visible");
  cy.getCy("territory-expansion-btn-analyze").should("be.visible");
  cy.getCy("territory-expansion-btn-identify").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Territory Expansion Manager Reports...");
  cy.waitAndSee();
  cy.screenshot("territory_expansion_manager_reports");
  
  cy.task("log", "✅ PROGRESS: - Verified Territory Expansion Manager Reports successfully!\n");

  });
});
