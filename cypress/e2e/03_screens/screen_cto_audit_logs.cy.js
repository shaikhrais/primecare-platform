// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - cto_audit_logs", () => {
  it("opens and verifies screen cto_audit_logs", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/corporate/roles/cto/audit-logs (Cto Audit Logs)...");
  cy.visitWithSemantics("/offices/corporate/roles/cto/audit-logs");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Cto Audit Logs...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("ctoauditlogs-screen").should("be.visible");
  cy.getCy("ctoauditlogs-title").should("be.visible");
  cy.getCy("ctoauditlogs-content").should("be.visible");
  cy.getCy("auditlog-summary").should("be.visible");
  cy.getCy("suspicious-activity-alert").should("be.visible");
  cy.getCy("access-pattern-chart").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Cto Audit Logs...");
  cy.waitAndSee();
  cy.screenshot("cto_audit_logs");
  
  cy.task("log", "✅ PROGRESS: - Verified Cto Audit Logs successfully!\n");

  });
});
