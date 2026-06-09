// AUTO-GENERATED FILE. DO NOT EDIT MANUALLY.
// Generated from SQLite governance database.
// Leverages custom reusable commands defined in cypress/support/commands.js.


describe("Screen - compliance_overview", () => {
  it("opens and verifies screen compliance_overview", () => {
    cy.loginAsRole("owner");

  cy.task("log", "⏳ PROGRESS: - Navigating to /executive/compliance-overview (ComplianceOverviewScreen)...");
  cy.visitWithSemantics("/executive/compliance-overview");
  cy.waitAndSee();
  
  cy.task("log", "🔍 PROGRESS: - Checking shell & content for ComplianceOverviewScreen...");
  cy.verifyShellExists();
  cy.verifyNotBlank();

  cy.getCy("complianceoverview-screen").should("be.visible");
  cy.getCy("complianceoverview-title").should("be.visible");
  cy.getCy("complianceoverview-content").should("be.visible");
  cy.getCy("franchise-dashboard-sales").should("be.visible");
  cy.getCy("franchise-dashboard-customer-feedback").should("be.visible");
  cy.getCy("franchise-dashboard-inventory").should("be.visible");

  cy.task("log", "📸 PROGRESS: - Saving screenshot for ComplianceOverviewScreen...");
  cy.waitAndSee();
  cy.screenshot("compliance_overview");
  
  cy.task("log", "✅ PROGRESS: - Verified ComplianceOverviewScreen successfully!\n");

  });
});
