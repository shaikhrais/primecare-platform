// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - remote_diagnosticser", () => {
  it("opens and verifies screen remote_diagnosticser", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Remote Diagnosticser)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Remote Diagnosticser...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("remotediagnosticser-screen").should("be.visible");
  cy.getCy("remotediagnosticser-title").should("be.visible");
  cy.getCy("remotediagnosticser-content").should("be.visible");
  cy.getCy("remote-diagnostics-btn-view-reports").should("be.visible");
  cy.getCy("remote-diagnostics-btn-generate-report").should("be.visible");
  cy.getCy("remote-diagnostics-btn-export-data").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Remote Diagnosticser...");
  cy.waitAndSee();
  cy.screenshot("remote_diagnosticser");
  
  cy.task("log", "✅ PROGRESS: - Verified Remote Diagnosticser successfully!\n");

  });
});
