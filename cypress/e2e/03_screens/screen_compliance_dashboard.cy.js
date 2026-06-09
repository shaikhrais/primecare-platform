// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - compliance_dashboard", () => {
  it("opens and verifies screen compliance_dashboard", () => {
    cy.loginAsRole("compliance");

  cy.task("log", "⏳ PROGRESS: - Navigating to /management/compliance-dashboard (ComplianceDashboardScreen)...");
  cy.visitWithSemantics("/management/compliance-dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for ComplianceDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("compliancedashboard-screen").should("be.visible");
  cy.getCy("compliancedashboard-title").should("be.visible");
  cy.getCy("compliancedashboard-content").should("be.visible");
  cy.getCy("compliance-dashboard-status").should("be.visible");
  cy.getCy("compliance-dashboard-audits").should("be.visible");
  cy.getCy("compliance-dashboard-activities").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for ComplianceDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("compliance_dashboard");
  
  cy.task("log", "✅ PROGRESS: - Verified ComplianceDashboardScreen successfully!\n");

  });
});
