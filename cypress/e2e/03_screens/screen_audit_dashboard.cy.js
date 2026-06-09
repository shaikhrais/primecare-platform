// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - audit_dashboard", () => {
  it("opens and verifies screen audit_dashboard", () => {
    cy.loginAsRole("chiropractor");

  cy.task("log", "⏳ PROGRESS: - Navigating to /generated/audit-dashboard (Audit Dashboard)...");
  cy.visitWithSemantics("/generated/audit-dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for Audit Dashboard...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("auditdashboard-screen").should("be.visible");
  cy.getCy("auditdashboard-title").should("be.visible");
  cy.getCy("auditdashboard-content").should("be.visible");
  cy.getCy("audit-dashboard-btn-generate-report").should("be.visible");
  cy.getCy("audit-dashboard-btn-review-activities").should("be.visible");
  cy.getCy("audit-dashboard-alert-suspicious-activity").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for Audit Dashboard...");
  cy.waitAndSee();
  cy.screenshot("audit_dashboard");
  
  cy.task("log", "✅ PROGRESS: - Verified Audit Dashboard successfully!\n");

  });
});
