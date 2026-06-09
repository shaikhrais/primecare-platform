// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - quality_assurance_compliance", () => {
  it("opens and verifies screen quality_assurance_compliance", () => {
    cy.loginAsRole("qa_specialist");

  cy.task("log", "⏳ PROGRESS: - Navigating to /staff/quality-assurance-compliance (QualityAssuranceComplianceScreen)...");
  cy.visitWithSemantics("/staff/quality-assurance-compliance");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for QualityAssuranceComplianceScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("qualityassurancecompliance-screen").should("be.visible");
  cy.getCy("qualityassurancecompliance-title").should("be.visible");
  cy.getCy("qualityassurancecompliance-content").should("be.visible");
  cy.getCy("qa-dashboard-compliance-status").should("be.visible");
  cy.getCy("qa-dashboard-performance-metrics").should("be.visible");
  cy.getCy("qa-dashboard-audit-log").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for QualityAssuranceComplianceScreen...");
  cy.waitAndSee();
  cy.screenshot("quality_assurance_compliance");
  
  cy.task("log", "✅ PROGRESS: - Verified QualityAssuranceComplianceScreen successfully!\n");

  });
});
