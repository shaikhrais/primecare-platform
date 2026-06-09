// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - protocol_resolution_log", () => {
  it("opens and verifies screen protocol_resolution_log", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Protocol Resolution Log)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Protocol Resolution Log...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("protocolresolutionlog-screen").should("be.visible");
  cy.getCy("protocolresolutionlog-title").should("be.visible");
  cy.getCy("protocolresolutionlog-content").should("be.visible");
  cy.getCy("protocol-resolution-log").should("be.visible");
  cy.getCy("refresh-logs-btn").should("be.visible");
  cy.getCy("download-report-btn").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Protocol Resolution Log...");
  cy.waitAndSee();
  cy.screenshot("protocol_resolution_log");
  
  cy.task("log", "✅ PROGRESS: - Verified Protocol Resolution Log successfully!\n");

  });
});
