// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - drift_findings", () => {
  it("opens and verifies screen drift_findings", () => {
    cy.loginAsRole("governance");

  cy.task("log", "⏳ PROGRESS: - Navigating to /common/drift-findings (DriftFindingsScreen)...");
  cy.visitWithSemantics("/common/drift-findings");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for DriftFindingsScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("driftfindings-screen").should("be.visible");
  cy.getCy("driftfindings-title").should("be.visible");
  cy.getCy("driftfindings-content").should("be.visible");
  cy.getCy("gov-dashboard-compliance-status").should("be.visible");
  cy.getCy("gov-dashboard-audit-logs").should("be.visible");
  cy.getCy("gov-dashboard-kpi").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for DriftFindingsScreen...");
  cy.waitAndSee();
  cy.screenshot("drift_findings");
  
  cy.task("log", "✅ PROGRESS: - Verified DriftFindingsScreen successfully!\n");

  });
});
