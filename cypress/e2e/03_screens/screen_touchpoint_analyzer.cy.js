// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - touchpoint_analyzer", () => {
  it("opens and verifies screen touchpoint_analyzer", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Touchpoint Analyzer)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Touchpoint Analyzer...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("touchpointanalyzer-screen").should("be.visible");
  cy.getCy("touchpointanalyzer-title").should("be.visible");
  cy.getCy("touchpointanalyzer-content").should("be.visible");
  cy.getCy("touchpoint-analyzer-btn-refresh").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Touchpoint Analyzer...");
  cy.waitAndSee();
  cy.screenshot("touchpoint_analyzer");
  
  cy.task("log", "✅ PROGRESS: - Verified Touchpoint Analyzer successfully!\n");

  });
});
