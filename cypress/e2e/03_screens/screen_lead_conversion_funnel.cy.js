// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - lead_conversion_funnel", () => {
  it("opens and verifies screen lead_conversion_funnel", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Lead Conversion Funnel)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Lead Conversion Funnel...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("leadconversionfunnel-screen").should("be.visible");
  cy.getCy("leadconversionfunnel-title").should("be.visible");
  cy.getCy("leadconversionfunnel-content").should("be.visible");
  cy.getCy("leadconversionfunnel-btn-refresh").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Lead Conversion Funnel...");
  cy.waitAndSee();
  cy.screenshot("lead_conversion_funnel");
  
  cy.task("log", "✅ PROGRESS: - Verified Lead Conversion Funnel successfully!\n");

  });
});
