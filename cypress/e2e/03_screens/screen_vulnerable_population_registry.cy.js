// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - vulnerable_population_registry", () => {
  it("opens and verifies screen vulnerable_population_registry", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Vulnerable Population Registry)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Vulnerable Population Registry...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("vulnerablepopulationregistry-screen").should("be.visible");
  cy.getCy("vulnerablepopulationregistry-title").should("be.visible");
  cy.getCy("vulnerablepopulationregistry-content").should("be.visible");
  cy.getCy("vulnerable-registry-btn-add").should("be.visible");
  cy.getCy("vulnerable-registry-btn-edit").should("be.visible");
  cy.getCy("vulnerable-registry-btn-delete").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Vulnerable Population Registry...");
  cy.waitAndSee();
  cy.screenshot("vulnerable_population_registry");
  
  cy.task("log", "✅ PROGRESS: - Verified Vulnerable Population Registry successfully!\n");

  });
});
