// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - security_audit", () => {
  it("opens and verifies screen security_audit", () => {
    cy.loginAsRole("cto");

  cy.task("log", "⏳ PROGRESS: - Navigating to /executive/security-audit (SecurityAuditScreen)...");
  cy.visitWithSemantics("/executive/security-audit");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for SecurityAuditScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("securityaudit-screen").should("be.visible");
  cy.getCy("securityaudit-title").should("be.visible");
  cy.getCy("securityaudit-content").should("be.visible");
  cy.getCy("ctodashboard-btn-refresh").should("be.visible");
  cy.getCy("ctodashboard-btn-view-report").should("be.visible");
  cy.getCy("ctodashboard-btn-export").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for SecurityAuditScreen...");
  cy.waitAndSee();
  cy.screenshot("security_audit");
  
  cy.task("log", "✅ PROGRESS: - Verified SecurityAuditScreen successfully!\n");

  });
});
