// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - receptionist_calls", () => {
  it("opens and verifies screen receptionist_calls", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to None (Receptionist Calls)...");
  cy.visitWithSemantics("");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Receptionist Calls...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("receptionistcalls-screen").should("be.visible");
  cy.getCy("receptionistcalls-title").should("be.visible");
  cy.getCy("receptionistcalls-content").should("be.visible");
  cy.getCy("receptionist-calls-status-indicator").should("be.visible");
  cy.getCy("receptionist-calls-audit-status").should("be.visible");
  cy.getCy("receptionist-calls-telemetry-chart").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Receptionist Calls...");
  cy.waitAndSee();
  cy.screenshot("receptionist_calls");
  
  cy.task("log", "✅ PROGRESS: - Verified Receptionist Calls successfully!\n");

  });
});
