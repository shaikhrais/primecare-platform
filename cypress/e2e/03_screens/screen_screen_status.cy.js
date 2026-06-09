// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - screen_status", () => {
  it("opens and verifies screen screen_status", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to /governance/screen-status (Screen Status)...");
  cy.visitWithSemantics("/governance/screen-status");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Screen Status...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("screen-details").should("be.visible");
  cy.getCy("screenstatus-title").should("be.visible");
  cy.getCy("screenstatus-content").should("be.visible");
  cy.getCy("deployment-selector").should("be.visible");
  cy.getCy("status-monitor").should("be.visible");
  cy.getCy("error-message-display").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Screen Status...");
  cy.waitAndSee();
  cy.screenshot("screen_status");
  
  cy.task("log", "✅ PROGRESS: - Verified Screen Status successfully!\n");

  });
});
