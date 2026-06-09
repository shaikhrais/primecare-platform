// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - audit_review", () => {
  it("opens and verifies screen audit_review", () => {
    cy.loginAsRole("compliance");

  cy.task("log", "⏳ PROGRESS: - Navigating to /management/audit-review (AuditReviewScreen)...");
  cy.visitWithSemantics("/management/audit-review");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for AuditReviewScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("auditreview-screen").should("be.visible");
  cy.getCy("auditreview-title").should("be.visible");
  cy.getCy("auditreview-content").should("be.visible");
  cy.getCy("compliance-status-overview").should("be.visible");
  cy.getCy("recent-audits-list").should("be.visible");
  cy.getCy("compliance-alerts").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for AuditReviewScreen...");
  cy.waitAndSee();
  cy.screenshot("audit_review");
  
  cy.task("log", "✅ PROGRESS: - Verified AuditReviewScreen successfully!\n");

  });
});
