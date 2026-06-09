// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - system_health", () => {
  it("opens and verifies screen system_health", () => {
    cy.loginAsRole("cto");

  cy.task("log", "⏳ PROGRESS: - Navigating to /executive/system-health (SystemHealthScreen)...");
  cy.visitWithSemantics("/executive/system-health");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for SystemHealthScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("systemhealth-screen").should("be.visible");
  cy.getCy("systemhealth-title").should("be.visible");
  cy.getCy("systemhealth-content").should("be.visible");
  cy.getCy("ctodashboard-btn-refresh").should("be.visible");
  cy.getCy("ctodashboard-btn-view-report").should("be.visible");
  cy.getCy("ctodashboard-btn-export").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for SystemHealthScreen...");
  cy.waitAndSee();
  cy.screenshot("system_health");
  
  cy.task("log", "✅ PROGRESS: - Verified SystemHealthScreen successfully!\n");

  });
});
