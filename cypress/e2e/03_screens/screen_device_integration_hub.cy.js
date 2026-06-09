// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - device_integration_hub", () => {
  it("opens and verifies screen device_integration_hub", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Device Integration Hub)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Device Integration Hub...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("deviceintegrationhub-screen").should("be.visible");
  cy.getCy("deviceintegrationhub-title").should("be.visible");
  cy.getCy("deviceintegrationhub-content").should("be.visible");
  cy.getCy("device-integration-status").should("be.visible");
  cy.getCy("device-configure-settings").should("be.visible");
  cy.getCy("user-permissions-manage").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Device Integration Hub...");
  cy.waitAndSee();
  cy.screenshot("device_integration_hub");
  
  cy.task("log", "✅ PROGRESS: - Verified Device Integration Hub successfully!\n");

  });
});
