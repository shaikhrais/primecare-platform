// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - compliance_manager_dashboard", () => {
  it("opens and verifies screen compliance_manager_dashboard", () => {
    cy.loginAsRole("compliance");

  cy.task("log", "⏳ PROGRESS: - Navigating to /offices/corporate/roles/compliance_manager/dashboard (ComplianceManagerDashboardScreen)...");
  cy.visitWithSemantics("/offices/corporate/roles/compliance_manager/dashboard");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for ComplianceManagerDashboardScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("compliancemanagerdashboard-screen").should("be.visible");
  cy.getCy("compliancemanagerdashboard-title").should("be.visible");
  cy.getCy("compliancemanagerdashboard-content").should("be.visible");
  cy.getCy("compliance-dashboard-btn-execute-scan").should("be.visible");
  cy.getCy("compliance-dashboard-btn-export-logs").should("be.visible");
  cy.getCy("compliance-dashboard-btn-refresh").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for ComplianceManagerDashboardScreen...");
  cy.waitAndSee();
  cy.screenshot("compliance_manager_dashboard");
  
  cy.task("log", "✅ PROGRESS: - Verified ComplianceManagerDashboardScreen successfully!\n");

  });
});
