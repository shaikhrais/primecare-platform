// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - quality_audit", () => {
  it("opens and verifies screen quality_audit", () => {
    cy.loginAsRole("qa_specialist");

  cy.task("log", "⏳ PROGRESS: - Navigating to /staff/quality-audit (QualityAuditScreen)...");
  cy.visitWithSemantics("/staff/quality-audit");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for QualityAuditScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("qualityaudit-screen").should("be.visible");
  cy.getCy("qualityaudit-title").should("be.visible");
  cy.getCy("qualityaudit-content").should("be.visible");
  cy.getCy("qa-compliance-scan-btn").should("be.visible");
  cy.getCy("qa-review-logs-btn").should("be.visible");
  cy.getCy("qa-generate-kpi-btn").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for QualityAuditScreen...");
  cy.waitAndSee();
  cy.screenshot("quality_audit");
  
  cy.task("log", "✅ PROGRESS: - Verified QualityAuditScreen successfully!\n");

  });
});
