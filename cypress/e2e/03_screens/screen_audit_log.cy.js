// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - audit_log", () => {
  it("opens and verifies screen audit_log", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to /governance/audit (Audit Log)...");
  cy.visitWithSemantics("/governance/audit");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Audit Log...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("auditlog-screen").should("be.visible");
  cy.getCy("auditlog-title").should("be.visible");
  cy.getCy("auditlog-content").should("be.visible");
  cy.getCy("auditlog-btn-generate-report").should("be.visible");
  cy.getCy("auditlog-btn-download-report").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Audit Log...");
  cy.waitAndSee();
  cy.screenshot("audit_log");
  
  cy.task("log", "✅ PROGRESS: - Verified Audit Log successfully!\n");

  });
});
