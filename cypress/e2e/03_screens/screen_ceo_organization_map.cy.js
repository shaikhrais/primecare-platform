// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - ceo_organization_map", () => {
  it("opens and verifies screen ceo_organization_map", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/corporate/roles/ceo/organization-map (Ceo Organization Map)...");
  cy.visitWithSemantics("/offices/corporate/roles/ceo/organization-map");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Ceo Organization Map...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("ceoorganizationmap-screen").should("be.visible");
  cy.getCy("ceoorganizationmap-title").should("be.visible");
  cy.getCy("ceoorganizationmap-content").should("be.visible");
  cy.getCy("orgmap-btn-refresh").should("be.visible");
  cy.getCy("orgmap-btn-submit-feedback").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Ceo Organization Map...");
  cy.waitAndSee();
  cy.screenshot("ceo_organization_map");
  
  cy.task("log", "✅ PROGRESS: - Verified Ceo Organization Map successfully!\n");

  });
});
