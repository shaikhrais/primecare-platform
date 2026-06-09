// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - integration_health_monitor", () => {
  it("opens and verifies screen integration_health_monitor", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Integration Health Monitor)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Integration Health Monitor...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("integrationhealthmonitor-screen").should("be.visible");
  cy.getCy("integrationhealthmonitor-title").should("be.visible");
  cy.getCy("integrationhealthmonitor-content").should("be.visible");
  cy.getCy("integration-health-refresh").should("be.visible");
  cy.getCy("integration-view-logs").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Integration Health Monitor...");
  cy.waitAndSee();
  cy.screenshot("integration_health_monitor");
  
  cy.task("log", "✅ PROGRESS: - Verified Integration Health Monitor successfully!\n");

  });
});
