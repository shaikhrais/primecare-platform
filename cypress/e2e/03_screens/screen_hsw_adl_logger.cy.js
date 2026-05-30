// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - hsw_adl_logger", () => {
  it("opens and verifies screen hsw_adl_logger", () => {
    cy.loginAsRole("hsw");

  cy.task("log", "⏳ PROGRESS: - Navigating to /clinical/hsw-adl-logger (HswAdlLoggerScreen)...");
  cy.visitWithSemantics("/clinical/hsw-adl-logger");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for HswAdlLoggerScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("hswadllogger-screen").should("be.visible");
  cy.getCy("hswadllogger-title").should("be.visible");
  cy.getCy("hswadllogger-content").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for HswAdlLoggerScreen...");
  cy.waitAndSee();
  cy.screenshot("hsw_adl_logger");
  
  cy.task("log", "✅ PROGRESS: - Verified HswAdlLoggerScreen successfully!\n");

  });
});
