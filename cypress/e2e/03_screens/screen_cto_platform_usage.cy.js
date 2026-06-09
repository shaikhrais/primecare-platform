// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - cto_platform_usage", () => {
  it("opens and verifies screen cto_platform_usage", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/corporate/roles/cto/platform-usage (Cto Platform Usage)...");
  cy.visitWithSemantics("/offices/corporate/roles/cto/platform-usage");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Cto Platform Usage...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("ctoplatformusage-screen").should("be.visible");
  cy.getCy("ctoplatformusage-title").should("be.visible");
  cy.getCy("ctoplatformusage-content").should("be.visible");
  cy.getCy("platform-usage-metrics").should("be.visible");
  cy.getCy("user-engagement-chart").should("be.visible");
  cy.getCy("usage-trends-graph").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Cto Platform Usage...");
  cy.waitAndSee();
  cy.screenshot("cto_platform_usage");
  
  cy.task("log", "✅ PROGRESS: - Verified Cto Platform Usage successfully!\n");

  });
});
