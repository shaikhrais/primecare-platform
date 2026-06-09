// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - tenant_configuration", () => {
  it("opens and verifies screen tenant_configuration", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Tenant Configuration)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Tenant Configuration...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("tenantconfiguration-screen").should("be.visible");
  cy.getCy("tenantconfiguration-title").should("be.visible");
  cy.getCy("tenantconfiguration-content").should("be.visible");
  cy.getCy("tenant-list").should("be.visible");
  cy.getCy("add-tenant-btn").should("be.visible");
  cy.getCy("billing-status-indicator").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Tenant Configuration...");
  cy.waitAndSee();
  cy.screenshot("tenant_configuration");
  
  cy.task("log", "✅ PROGRESS: - Verified Tenant Configuration successfully!\n");

  });
});
